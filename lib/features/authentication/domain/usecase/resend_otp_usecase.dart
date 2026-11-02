import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/resend_otp_request.dart';
import '../repository/auth_repository.dart';

class ResendOtpUseCase {
  final AuthRepository _repository;

  ResendOtpUseCase(this._repository);

  Future<Either<Failure, String>> call(ResendOtpRequest request) {
    return _repository.resendOtp(request);
  }
}

