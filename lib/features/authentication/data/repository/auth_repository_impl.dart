import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/services/storage_services/storage_service.dart';
import '../../domain/model/auth_token_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../mapper/login_mapper.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/verify_email_request.dart';
import '../response/login_response.dart';

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
        }

        return domainModel;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> register(RegisterRequest request) {
    return fastHandler<void, Unit>(
      request: () => _remoteDataSource.register(request),
      mapper: (_) => unit,
    );
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail(VerifyEmailRequest request) {
    return fastHandler<void, Unit>(
      request: () => _remoteDataSource.verifyEmail(request),
      mapper: (_) => unit,
    );
  }
}
