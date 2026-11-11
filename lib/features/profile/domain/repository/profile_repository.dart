import 'package:dartz/dartz.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../model/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getMe();
  Future<Either<Failure, String>> logout();
}