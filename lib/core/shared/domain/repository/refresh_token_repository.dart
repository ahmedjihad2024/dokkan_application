import 'package:dartz/dartz.dart';
import 'package:dokkan/core/network/error_handler/failure.dart';

import '../../data/request/refresh_token_request.dart';
import '../model/refresh_token_entity.dart';

abstract class RefreshTokenRepository {
  Future<Either<Failure, RefreshTokenEntity>> refreshToken(
    RefreshTokenRequest request,
  );
}

