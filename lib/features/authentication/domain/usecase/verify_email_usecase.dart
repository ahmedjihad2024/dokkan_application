import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/verify_email_request.dart';
import '../repository/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository _repository;

  VerifyEmailUseCase(this._repository);

  Future<Either<Failure, Unit>> call(VerifyEmailRequest request) {
    return _repository.verifyEmail(request);
  }
}