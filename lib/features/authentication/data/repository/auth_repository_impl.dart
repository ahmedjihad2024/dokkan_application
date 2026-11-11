import 'package:dartz/dartz.dart';

import '../../../../core/auth/app_auth_cubit.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/network/base_response.dart';
import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/services/storage_services/storage_service.dart';
import '../../../../core/shared/domain/model/user_profile_entity.dart';
import '../../domain/model/auth_token_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../mapper/current_user_mapper.dart';
import '../mapper/login_mapper.dart';
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

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  AuthRepositoryImpl(this._remoteDataSource, this._storageService);

  @override
  Future<Either<Failure, AuthTokenModel>> login(LoginRequest request) {
    return fastHandler<LoginResponse, AuthTokenModel>(
      request: () => _remoteDataSource.login(request),
      mapper: (response) {
        final domainModel = response.toDomain();

        if (domainModel.accessToken.isNotEmpty) {
          _storageService.saveAuthTokens(
            accessToken: domainModel.accessToken,
            refreshToken: domainModel.refreshToken,
          );
          if (response.expiresAtUtc != null &&
              response.expiresAtUtc!.isNotEmpty) {
            _storageService.saveTokenExpiry(response.expiresAtUtc!);
          }
          sl<AppAuthCubit>().loggedIn();
        }

        return domainModel;
      },
    );
  }

  @override
  Future<Either<Failure, String>> register(RegisterRequest request) {
    return fastHandler<RegisterResponse, String>(
      request: () => _remoteDataSource.register(request),
      mapper: (response) => response.message,
    );
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getCurrentUser() {
    return fastHandler<CurrentUserResponse, UserProfileEntity>(
      request: () => _remoteDataSource.getCurrentUser(),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, String>> verifyEmail(VerifyEmailRequest request) {
    return fastHandler<BaseResponse, String>(
      request: () => _remoteDataSource.verifyEmail(request),
      mapper: (response) => response.message,
    );
  }

  @override
  Future<Either<Failure, String>> resendOtp(ResendOtpRequest request) {
    return fastHandler<BaseResponse, String>(
      request: () => _remoteDataSource.resendOtp(request),
      mapper: (response) => response.message,
    );
  }

  @override
  Future<Either<Failure, String>> forgotPassword(ForgotPasswordRequest request) {
    return fastHandler<BaseResponse, String>(
      request: () => _remoteDataSource.forgotPassword(request),
      mapper: (response) => response.message,
    );
  }

  @override
  Future<Either<Failure, String>> validateOtp(ValidateOtpRequest request) {
    return fastHandler<BaseResponse, String>(
      request: () => _remoteDataSource.validateOtp(request),
      mapper: (response) => response.message,
    );
  }

  @override
  Future<Either<Failure, String>> resetPassword(ResetPasswordRequest request) {
    return fastHandler<BaseResponse, String>(
      request: () => _remoteDataSource.resetPassword(request),
      mapper: (response) => response.message,
    );
  }
}
