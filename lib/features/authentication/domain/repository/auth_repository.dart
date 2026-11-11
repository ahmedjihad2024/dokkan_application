import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/user_profile_entity.dart';
import '../../data/request/change_password_request.dart';
import '../../data/request/forgot_password_request.dart';
import '../../data/request/login_request.dart';
import '../../data/request/register_request.dart';
import '../../data/request/resend_otp_request.dart';
import '../../data/request/reset_password_request.dart';
import '../../data/request/validate_otp_request.dart';
import '../../data/request/verify_email_request.dart';
import '../model/auth_token_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenModel>> login(LoginRequest request);
  Future<Either<Failure, String>> register(RegisterRequest request);
  Future<Either<Failure, UserProfileEntity>> getCurrentUser();
  Future<Either<Failure, String>> verifyEmail(VerifyEmailRequest request);
  Future<Either<Failure, String>> resendOtp(ResendOtpRequest request);
  Future<Either<Failure, String>> forgotPassword(ForgotPasswordRequest request);
  Future<Either<Failure, String>> validateOtp(ValidateOtpRequest request);
  Future<Either<Failure, String>> resetPassword(ResetPasswordRequest request);
  Future<Either<Failure, String>> changePassword(ChangePasswordRequest request);
}
