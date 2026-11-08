import 'package:dio/dio.dart';

import '../request/refresh_token_request.dart';
import '../response/refresh_token_response.dart';

abstract class RefreshTokenApiService {
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request);
}

class RefreshTokenApiServiceImpl implements RefreshTokenApiService {
  final Dio _dio;

  RefreshTokenApiServiceImpl(this._dio);

  @override
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request) async {
    final response = await _dio.post(
      '/api/auth/refresh-token',
      data: request.toJson(),
    );

    return RefreshTokenResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

