import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/change_password_request.dart';
import '../repository/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Either<Failure, String>> call(ChangePasswordRequest request) {
    return _repository.changePassword(request);
  }
}

