import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/login_request.dart';
import '../model/auth_token_model.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, AuthTokenModel>> call(LoginRequest request) {
    return _repository.login(request);
  }
}

