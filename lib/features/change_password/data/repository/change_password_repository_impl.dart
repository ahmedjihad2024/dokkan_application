import 'package:dartz/dartz.dart';

import '../../../../core/network/base_response.dart';
import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../domain/repository/change_password_repository.dart';
import '../data_source/change_password_remote_data_source.dart';
import '../request/change_password_request.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordRemoteDataSource _remoteDataSource;

  ChangePasswordRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, String>> changePassword(
    ChangePasswordRequest request,
  ) {
    return fastHandler<BaseResponse, String>(
      request: () => _remoteDataSource.changePassword(request),
      mapper: (response) => response.message,
    );
  }
}
