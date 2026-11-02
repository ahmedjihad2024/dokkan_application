import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/login_request.dart';
import '../../data/request/register_request.dart';
import '../model/auth_token_model.dart';
import '../../data/request/verify_email_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenModel>> login(LoginRequest request);

  Future<Either<Failure, Unit>> register(RegisterRequest request);
  Future<Either<Failure, Unit>> verifyEmail(VerifyEmailRequest request);
}
