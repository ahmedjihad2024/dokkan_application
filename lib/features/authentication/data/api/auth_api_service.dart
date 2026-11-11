import 'package:dokkan/core/network/dio_factory.dart';
import 'package:dokkan/features/authentication/data/request/verify_email_request.dart';

import '../../../../core/network/base_response.dart';
import '../request/change_password_request.dart';
import '../request/forgot_password_request.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/resend_otp_request.dart';
import '../request/reset_password_request.dart';
import '../request/validate_otp_request.dart';
import '../response/current_user_response.dart';
import '../response/login_response.dart';
import '../response/register_response.dart';

abstract class AuthApiService {
  Future<LoginResponse> login(LoginRequest request);

  Future<RegisterResponse> register(RegisterRequest request);

  Future<CurrentUserResponse> getCurrentUser();

  Future<BaseResponse> verifyEmail(VerifyEmailRequest request);

  Future<BaseResponse> resendOtp(ResendOtpRequest request);

  Future<BaseResponse> forgotPassword(ForgotPasswordRequest request);

  Future<BaseResponse> validateOtp(ValidateOtpRequest request);

  Future<BaseResponse> resetPassword(ResetPasswordRequest request);

  Future<BaseResponse> changePassword(ChangePasswordRequest request);
}

class AuthApiServiceImpl implements AuthApiService {
  final DioFactory _dio;

  AuthApiServiceImpl(this._dio);

  BaseResponse _parseBaseResponse(dynamic data, {String defaultMessage = 'Success'}) {
    if (data is Map<String, dynamic>) {
      return BaseResponse.fromJson(data);
    }
    final text = data is String ? data.trim() : '';
    return BaseResponse(
      status: true,
      message: text.isNotEmpty ? text : defaultMessage,
    );
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.request(
      '/api/auth/login',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return LoginResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _dio.request(
      '/api/auth/register',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return RegisterResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CurrentUserResponse> getCurrentUser() async {
    final response = await _dio.request(
      '/api/auth/me',
      method: RequestMethod.GET,
    );

    return CurrentUserResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<BaseResponse> verifyEmail(VerifyEmailRequest request) async {
    final response = await _dio.request(
      '/api/auth/verify-email',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return _parseBaseResponse(response.data);
  }

  @override
  Future<BaseResponse> resendOtp(ResendOtpRequest request) async {
    final response = await _dio.request(
      '/api/auth/resend-otp',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return _parseBaseResponse(response.data);
  }

  @override
  Future<BaseResponse> forgotPassword(ForgotPasswordRequest request) async {
    final response = await _dio.request(
      '/api/auth/forgot-password',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return _parseBaseResponse(
      response.data,
      defaultMessage: 'Recovery code sent successfully',
    );
  }

  @override
  Future<BaseResponse> validateOtp(ValidateOtpRequest request) async {
    final response = await _dio.request(
      '/api/auth/validate-otp',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return _parseBaseResponse(
      response.data,
      defaultMessage: 'Code verified successfully',
    );
  }

  @override
  Future<BaseResponse> resetPassword(ResetPasswordRequest request) async {
    final response = await _dio.request(
      '/api/auth/reset-password',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return _parseBaseResponse(
      response.data,
      defaultMessage: 'Password reset successfully',
    );
  }

  @override
  Future<BaseResponse> changePassword(ChangePasswordRequest request) async {
    final response = await _dio.request(
      '/api/auth/change-password',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return _parseBaseResponse(
      response.data,
      defaultMessage: 'Password has been changed successfully.',
    );
  }
}
