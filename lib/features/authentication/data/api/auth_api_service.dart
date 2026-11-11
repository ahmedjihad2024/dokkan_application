import 'package:dio/dio.dart';

import '../../../../core/network/base_response.dart';
import '../../../change_password/data/request/change_password_request.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/resend_otp_request.dart';
import '../request/verify_email_request.dart';
import '../response/login_response.dart';
import '../response/register_response.dart';

abstract class AuthApiService {
  Future<LoginResponse> login(LoginRequest request);

  Future<RegisterResponse> register(RegisterRequest request);

  Future<BaseResponse> verifyEmail(VerifyEmailRequest request);

  Future<BaseResponse> resendOtp(ResendOtpRequest request);

  Future<BaseResponse> changePassword(ChangePasswordRequest request);
}

class AuthApiServiceImpl implements AuthApiService {
  final Dio _dio;

  AuthApiServiceImpl(this._dio);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post('/api/auth/login', data: request.toJson());

    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _dio.post(
      '/api/auth/register',
      data: request.toJson(),
    );

    return RegisterResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<BaseResponse> verifyEmail(VerifyEmailRequest request) async {
    final response = await _dio.post(
      '/api/auth/verify-email',
      data: request.toJson(),
    );

    return BaseResponse(status: true, message: response.data as String);
  }

  @override
  Future<BaseResponse> resendOtp(ResendOtpRequest request) async {
    final response = await _dio.post(
      '/api/auth/resend-otp',
      data: request.toJson(),
    );

    return BaseResponse(status: true, message: response.data as String);
  }

  @override
  Future<BaseResponse> changePassword(ChangePasswordRequest request) async {
    final response = await _dio.post(
      '/api/auth/change-password',
      data: request.toJson(),
    );

    String message = 'Password changed successfully';

    if (response.data is Map<String, dynamic>) {
      message = response.data['message']?.toString() ?? message;
    } else if (response.data is String) {
      message = response.data;
    }

    return BaseResponse(status: true, message: message);

  }
}
