import 'package:dartz/dartz.dart';

import '../../../network/error_handler/error_handler.dart';
import '../../../network/error_handler/failure.dart';
import '../../domain/model/refresh_token_entity.dart';
import '../../domain/repository/refresh_token_repository.dart';
import '../data_source/refresh_token_remote_data_source.dart';
import '../mapper/refresh_token_mapper.dart';
import '../request/refresh_token_request.dart';
import '../response/refresh_token_response.dart';

class RefreshTokenRepositoryImpl implements RefreshTokenRepository {
  final RefreshTokenRemoteDataSource _remoteDataSource;

  RefreshTokenRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, RefreshTokenEntity>> refreshToken(
    RefreshTokenRequest request,
  ) {
    return fastHandler<RefreshTokenResponse, RefreshTokenEntity>(
      request: () => _remoteDataSource.refreshToken(request),
      mapper: (response) => response.toDomain(),
    );
  }
}

