import 'package:dio/dio.dart';

import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/verify_email_request.dart';
import '../response/login_response.dart';

abstract class AuthApiService {
  Future<LoginResponse> login(LoginRequest request);

  Future<void> register(RegisterRequest request);

  Future<void> verifyEmail(VerifyEmailRequest request);
}

class AuthApiServiceImpl implements AuthApiService {
  final Dio _dio;

  AuthApiServiceImpl(this._dio);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      '/api/auth/login',
      data: request.toJson(),
    );

    return LoginResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> register(RegisterRequest request) async {
    await _dio.post(
      '/api/auth/register',
      data: request.toJson(),
    );
  }

  @override
  Future<void> verifyEmail(VerifyEmailRequest request) async {
    await _dio.post(
      '/api/auth/verify-email',
      data: request.toJson(),
    );
  }
}