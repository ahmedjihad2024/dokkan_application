import 'package:dartz/dartz.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/change_password_request.dart';
import '../repository/change_password_repository.dart';

class ChangePasswordUseCase {
  final ChangePasswordRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Either<Failure, void>> call(ChangePasswordRequest request) async {
    return await _repository.changePassword(request);
  }
}