import 'package:dartz/dartz.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/change_password_request.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, void>> changePassword(ChangePasswordRequest request);
}