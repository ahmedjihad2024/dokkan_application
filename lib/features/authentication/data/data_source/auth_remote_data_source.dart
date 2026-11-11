import '../../../../core/network/base_response.dart';
import '../api/auth_api_service.dart';
import '../request/forgot_password_request.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/resend_otp_request.dart';
import '../request/reset_password_request.dart';
import '../request/validate_otp_request.dart';
import '../request/verify_email_request.dart';
import '../response/current_user_response.dart';
import '../response/login_response.dart';
import '../response/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);

  Future<RegisterResponse> register(RegisterRequest request);

  Future<CurrentUserResponse> getCurrentUser();

  Future<BaseResponse> verifyEmail(VerifyEmailRequest request);

  Future<BaseResponse> resendOtp(ResendOtpRequest request);

  Future<BaseResponse> forgotPassword(ForgotPasswordRequest request);

  Future<BaseResponse> validateOtp(ValidateOtpRequest request);

  Future<BaseResponse> resetPassword(ResetPasswordRequest request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<LoginResponse> login(LoginRequest request) {
    return _apiService.login(request);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) {
    return _apiService.register(request);
  }

  @override
  Future<CurrentUserResponse> getCurrentUser() {
    return _apiService.getCurrentUser();
  }

  @override
  Future<BaseResponse> verifyEmail(VerifyEmailRequest request) {
    return _apiService.verifyEmail(request);
  }

  @override
  Future<BaseResponse> resendOtp(ResendOtpRequest request) {
    return _apiService.resendOtp(request);
  }

  @override
  Future<BaseResponse> forgotPassword(ForgotPasswordRequest request) {
    return _apiService.forgotPassword(request);
  }

  @override
  Future<BaseResponse> validateOtp(ValidateOtpRequest request) {
    return _apiService.validateOtp(request);
  }

  @override
  Future<BaseResponse> resetPassword(ResetPasswordRequest request) {
    return _apiService.resetPassword(request);
  }
}
