import 'package:dartz/dartz.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../model/user_entity.dart';
import '../repository/profile_repository.dart';

class GetMeUseCase {
  final ProfileRepository _repository;

  GetMeUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call() => _repository.getMe();
}
