import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dokkan/core/auth/app_auth_cubit.dart';
import 'package:dokkan/core/di/dependency_injection.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:dokkan/core/shared/data/api/refresh_token_api_service.dart';
import 'package:dokkan/core/shared/data/request/refresh_token_request.dart';

class _InvalidRefreshException implements Exception {
  final String message;
  const _InvalidRefreshException([this.message = 'Invalid refresh token response']);

  @override
  String toString() => '_InvalidRefreshException: $message';
}

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;
  final RefreshTokenApiService _refreshTokenApiService;
  final AppAuthCubit _appAuthCubit;
  final Dio? _dio;

  Future<void>? _refreshing;

  AuthInterceptor(
    this._storageService, {
    RefreshTokenApiService? refreshTokenApiService,
    AppAuthCubit? appAuthCubit,
    Dio? dio,
  })  : _refreshTokenApiService =
            refreshTokenApiService ?? sl<RefreshTokenApiService>(),
        _appAuthCubit = appAuthCubit ?? sl<AppAuthCubit>(),
        _dio = dio;

  Dio get _effectiveDio => _dio ?? sl<Dio>();

  bool _isAuthEndpoint(String path) {
    final p = path.toLowerCase();
    return p.contains('/auth/login') ||
        p.contains('/auth/register') ||
        p.contains('/account/login') ||
        p.contains('/account/register') ||
        p.contains('/auth/refresh-token');
  }

  bool _isSessionDead(Object e) {
    if (e is _InvalidRefreshException) return true;
    if (e is DioException) {
      final code = e.response?.statusCode;
      return code == 400 || code == 401 || code == 403;
    }
    return false;
  }

  Future<void> _refresh(String refreshToken) async {
    try {
      final response = await _refreshTokenApiService.refreshToken(
        RefreshTokenRequest(
          refreshToken: refreshToken,
          useCookies: false,
        ),
      );

      final newAccessToken = response.accessToken;
      final newRefreshToken = response.refreshToken;

      if (newAccessToken == null ||
          newAccessToken.trim().isEmpty ||
          newRefreshToken == null ||
          newRefreshToken.trim().isEmpty) {
        throw const _InvalidRefreshException(
          'Null or empty tokens received from refresh',
        );
      }

      await _storageService.saveAuthTokens(
        accessToken: newAccessToken.trim(),
        refreshToken: newRefreshToken.trim(),
      );

      final expiry = response.expiresAtUtc;
      if (expiry != null && expiry.trim().isNotEmpty) {
        await _storageService.saveTokenExpiry(expiry.trim());
      }
    } catch (e) {
      if (_isSessionDead(e)) {
        await _storageService.clearAuthTokens();
        _appAuthCubit.sessionExpired();
      }
      rethrow;
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path;
    if (_isAuthEndpoint(path)) {
      return handler.next(options);
    }

    final expireAt = _storageService.getTokenExpiry();
    final isExpired = expireAt != null &&
        expireAt.toUtc().isBefore(
              DateTime.now().toUtc().add(const Duration(seconds: 30)),
            );

    if (isExpired) {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null || refreshToken.trim().isEmpty) {
        await _storageService.clearAuthTokens();
        _appAuthCubit.sessionExpired();
        return handler.reject(
          DioException(
            requestOptions: options,
            error: const _InvalidRefreshException('No refresh token available'),
            type: DioExceptionType.unknown,
          ),
          true,
        );
      }

      try {
        _refreshing ??= _refresh(refreshToken).whenComplete(() {
          _refreshing = null;
        });
        await _refreshing;
      } catch (e) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: e,
            type: DioExceptionType.unknown,
          ),
          true,
        );
      }
    }

    final token = await _storageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final isRetried = err.requestOptions.extra['retried'] == true;
    final isAuth = _isAuthEndpoint(err.requestOptions.path);

    if (statusCode == 401 && !isAuth && !isRetried) {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken != null && refreshToken.trim().isNotEmpty) {
        try {
          _refreshing ??= _refresh(refreshToken).whenComplete(() {
            _refreshing = null;
          });
          await _refreshing;

          final newAccessToken = await _storageService.getAccessToken();
          final requestOptions = err.requestOptions;
          requestOptions.extra['retried'] = true;
          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            requestOptions.headers['authorization'] = 'Bearer $newAccessToken';
          }

          final response = await _effectiveDio.fetch(requestOptions);
          return handler.resolve(response);
        } catch (_) {
          return handler.next(err);
        }
      }
    }

    return handler.next(err);
  }
}
