import 'package:dartz/dartz.dart';
import 'package:dokkan/core/network/error_handler/failure.dart';

import '../../data/request/refresh_token_request.dart';
import '../model/refresh_token_entity.dart';
import '../repository/refresh_token_repository.dart';

class RefreshTokenUseCase {
  final RefreshTokenRepository _repository;

  RefreshTokenUseCase(this._repository);

  Future<Either<Failure, RefreshTokenEntity>> call(
    RefreshTokenRequest request,
  ) {
    return _repository.refreshToken(request);
  }
}

