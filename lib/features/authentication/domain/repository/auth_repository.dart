import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/login_request.dart';
import '../model/auth_token_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenModel>> login(LoginRequest request);
}

