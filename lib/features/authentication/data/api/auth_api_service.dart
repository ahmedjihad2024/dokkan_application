import 'package:dio/dio.dart';
import 'package:dokkan/features/authentication/data/request/verify_email_request.dart';

import '../../../../core/network/base_response.dart';
import '../request/forgot_password_request.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/resend_otp_request.dart';
import '../request/reset_password_request.dart';
import '../request/validate_otp_request.dart';
import '../response/login_response.dart';
import '../response/register_response.dart';

abstract class AuthApiService {
  Future<LoginResponse> login(LoginRequest request);

  Future<RegisterResponse> register(RegisterRequest request);

  Future<BaseResponse> verifyEmail(VerifyEmailRequest request);

  Future<BaseResponse> resendOtp(ResendOtpRequest request);

  Future<BaseResponse> forgotPassword(ForgotPasswordRequest request);

  Future<BaseResponse> validateOtp(ValidateOtpRequest request);

  Future<BaseResponse> resetPassword(ResetPasswordRequest request);
}

class AuthApiServiceImpl implements AuthApiService {
  final Dio _dio;

  AuthApiServiceImpl(this._dio);

  BaseResponse _parseBaseResponse(dynamic data, {String defaultMessage = 'Success'}) {
    if (data is Map<String, dynamic>) {
      return BaseResponse.fromJson(data);
    }
    return BaseResponse(
      status: true,
      message: data is String ? data : defaultMessage,
    );
  }

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

    return _parseBaseResponse(response.data);
  }

  @override
  Future<BaseResponse> resendOtp(ResendOtpRequest request) async {
    final response = await _dio.post(
      '/api/auth/resend-otp',
      data: request.toJson(),
    );

    return _parseBaseResponse(response.data);
  }

  @override
  Future<BaseResponse> forgotPassword(ForgotPasswordRequest request) async {
    final response = await _dio.post(
      '/api/auth/forgot-password',
      data: request.toJson(),
    );

    return _parseBaseResponse(
      response.data,
      defaultMessage: 'Recovery code sent successfully',
    );
  }

  @override
  Future<BaseResponse> validateOtp(ValidateOtpRequest request) async {
    final response = await _dio.post(
      '/api/auth/validate-otp',
      data: request.toJson(),
    );

    return _parseBaseResponse(
      response.data,
      defaultMessage: 'Code verified successfully',
    );
  }

  @override
  Future<BaseResponse> resetPassword(ResetPasswordRequest request) async {
    final response = await _dio.post(
      '/api/auth/reset-password',
      data: request.toJson(),
    );

    return _parseBaseResponse(
      response.data,
      defaultMessage: 'Password reset successfully',
    );
  }
}
