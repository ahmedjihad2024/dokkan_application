import 'package:dartz/dartz.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../repository/profile_repository.dart';

class LogoutUseCase {
  final ProfileRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, String>> call() => _repository.logout();
}
