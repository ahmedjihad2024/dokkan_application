import 'package:dartz/dartz.dart';

import '../../../../core/network/base_response.dart';
import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/services/storage_services/storage_service.dart';
import '../../domain/model/user_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_remote_data_source.dart';
import '../response/user_response.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  ProfileRepositoryImpl(this._remoteDataSource, this._storageService);

  @override
  Future<Either<Failure, UserEntity>> getMe() {
    return fastHandler<UserResponse, UserEntity>(
      request: () => _remoteDataSource.getMe(),
      mapper: (response) => response.data!.toEntity(),
    );
  }

  @override
  Future<Either<Failure, String>> logout() {
    return fastHandler<BaseResponse, String>(
      request: () => _remoteDataSource.logout(),
      mapper: (response) {
        _storageService.clearAuthTokens();
        return response.message;
      },
    );
  }
}
