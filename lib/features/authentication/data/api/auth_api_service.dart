import 'package:dio/dio.dart';

import '../../../../core/network/base_response.dart';
<<<<<<< Updated upstream
=======
import '../../../change_password/data/request/change_password_request.dart';
import '../../../profile/data/response/user_response.dart';
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======

  Future<BaseResponse> changePassword(ChangePasswordRequest request);

  Future<UserResponse> getMe();

  Future<BaseResponse> logout();
>>>>>>> Stashed changes
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

    return BaseResponse(
      status: true,
      message: response.data as String,
    );
  }

  @override
  Future<BaseResponse> resendOtp(ResendOtpRequest request) async {
    final response = await _dio.post(
      '/api/auth/resend-otp',
      data: request.toJson(),
    );

    return BaseResponse(
      status: true,
      message: response.data as String,
    );
<<<<<<< Updated upstream
=======

    String message = 'Password changed successfully';

    if (response.data is Map<String, dynamic>) {
      message = response.data['message']?.toString() ?? message;
    } else if (response.data is String) {
      message = response.data;
    }

    return BaseResponse(status: true, message: message);
  }

  @override
  Future<UserResponse> getMe() async {
    final response = await _dio.get('/api/auth/me');
    print('🔴🔴🔴🔴🔴🔴🔴🔴🔴 GET ME RESPONSE: ${response.data}🔴🔴🔴🔴🔴🔴🔴🔴');
    final data = response.data is Map<String, dynamic>
        ? response.data
        : <String, dynamic>{};

    return UserResponse.fromJson(data);
  }

  @override
  Future<BaseResponse> logout() async {
    final response = await _dio.post('/api/auth/logout');

    final data = response.data is Map<String, dynamic>
        ? response.data
        : <String, dynamic>{};

    return BaseResponse(
      status:
          data['status'] == true ||
          data['status'] == 'true' ||
          data['status'] == 1,
      message: data['message']?.toString() ?? 'Logged out successfully',
    );
>>>>>>> Stashed changes
  }
}
