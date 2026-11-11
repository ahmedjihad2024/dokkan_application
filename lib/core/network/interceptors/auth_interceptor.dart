import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dokkan/core/auth/app_auth_cubit.dart';
import 'package:dokkan/core/di/dependency_injection.dart';
import 'package:dokkan/core/network/dio_factory.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:dokkan/core/shared/data/api/refresh_token_api_service.dart';
import 'package:dokkan/core/shared/data/request/refresh_token_request.dart';
import 'package:dokkan/core/shared/data/response/refresh_token_response.dart';
import 'package:intl/intl.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage, {AppAuthCubit? appAuthCubit, Dio? dio})
    : _authCubit = appAuthCubit ?? sl<AppAuthCubit>(),
      _dio = dio;

  final StorageService _storage;
  final AppAuthCubit _authCubit;
  final Dio? _dio;

  Future<void>? _refreshing;

  static const _authPaths = [
    '/auth/login',
    '/auth/register',
    '/account/login',
    '/account/register',
    '/auth/refresh-token',
  ];

  bool _isAuthPath(String path) {
    final p = path.toLowerCase();
    return _authPaths.any(p.contains);
  }

  /// All callers share a single in-flight refresh.
  Future<void> _refresh() =>
      _refreshing ??= _doRefresh().whenComplete(() => _refreshing = null);

  Future<void> _doRefresh() async {
    try {
      final refreshToken = (await _storage.getRefreshToken())?.trim();
      if (refreshToken == null || refreshToken.isEmpty) {
        throw StateError('No refresh token available');
      }

      final response = await _dio!.post(
        '/api/auth/refresh-token',
        data: RefreshTokenRequest(
          refreshToken: refreshToken,
          useCookies: false,
        ).toJson(),
      );

      final res = RefreshTokenResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      final access = res.accessToken?.trim();
      final refresh = res.refreshToken?.trim();
      if (access == null ||
          access.isEmpty ||
          refresh == null ||
          refresh.isEmpty) {
        throw StateError('Invalid refresh token response');
      }

      await _storage.saveAuthTokens(accessToken: access, refreshToken: refresh);

      final expiry = res.expiresAtUtc?.trim();
      if (expiry != null && expiry.isNotEmpty) {
        await _storage.saveTokenExpiry(expiry);
      }
    } catch (e) {
      final code = e is DioException ? e.response?.statusCode : null;
      final sessionDead =
          e is StateError || const [400, 401, 403].contains(code);
      if (sessionDead) {
        await _storage.clearAuthTokens();
        _authCubit.sessionExpired();
      }
      rethrow;
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isAuthPath(options.path)) return handler.next(options);

    final expiry = _storage.getTokenExpiry();

    final isExpired =
        expiry != null &&
        expiry.toUtc().isBefore(
          DateTime.now().toUtc().add(const Duration(seconds: 30)),
        );

    if (isExpired) {
      try {
        await _refresh();
      } catch (e) {
        return handler.reject(
          DioException(requestOptions: options, error: e),
          true,
        );
      }
    }

    final token = await _storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.requestOptions;

    if (err.response?.statusCode != 401 ||
        _isAuthPath(req.path) ||
        req.extra['retried'] == true) {
      return handler.next(err);
    }

    try {
      // Only refresh if nobody else already did since this request was sent.
      final current = await _storage.getAccessToken();
      if (req.headers['authorization'] == 'Bearer $current') {
        await _refresh();
      }

      req.extra['retried'] = true; // onRequest re-applies the new token
      handler.resolve(await (_dio ?? sl<Dio>()).fetch(req));
    } catch (_) {
      handler.next(err);
    }
  }
}
