import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/reset_password_request.dart';
import '../repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Either<Failure, String>> call(ResetPasswordRequest request) {
    return _repository.resetPassword(request);
  }
}

