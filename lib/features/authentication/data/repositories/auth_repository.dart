import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';

abstract class AuthRepository {
  Future<void> forgotPassword(String email);
  Future<void> validateOtp(String email, String otp);
  Future<void> resendOtp(String email);
  Future<void> resetPassword(String email, String otp, String newPassword);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({Dio? dio}) : _dio = dio ?? ApiClient.dio;
  final Dio _dio;

  @override
  Future<void> forgotPassword(String email) async {
    await _dio.post('/api/auth/forgot-password', data: {'email': email});
  }

  @override
  Future<void> validateOtp(String email, String otp) async {
    await _dio.post(
      '/api/auth/validate-otp',
      data: {'email': email, 'otp': otp},
    );
  }

  @override
  Future<void> resendOtp(String email) async {
    await _dio.post('/api/auth/resend-otp', data: {'email': email});
  }

  @override
  Future<void> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    await _dio.post(
      '/api/auth/reset-password',
      data: {'email': email, 'otp': otp, 'newPassword': newPassword},
    );
  }
}
