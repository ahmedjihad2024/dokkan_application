import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/validate_otp_request.dart';
import '../repository/auth_repository.dart';

class ValidateOtpUseCase {
  final AuthRepository _repository;

  ValidateOtpUseCase(this._repository);

  Future<Either<Failure, String>> call(ValidateOtpRequest request) {
    return _repository.validateOtp(request);
  }
}

