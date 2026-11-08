import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/forgot_password_request.dart';
import '../repository/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<Either<Failure, String>> call(ForgotPasswordRequest request) {
    return _repository.forgotPassword(request);
  }
}

