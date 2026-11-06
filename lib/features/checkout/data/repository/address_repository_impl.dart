import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../domain/model/address_entity.dart';
import '../../domain/repository/address_repository.dart';
import '../data_source/address_remote_data_source.dart';
import '../mapper/address_mapper.dart';
import '../request/address_request.dart';
import '../response/address_response.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource _remoteDataSource;

  AddressRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AddressEntity>> createAddress(AddressRequest request) {
    return fastHandler<AddressResponse, AddressEntity>(
      request: () => _remoteDataSource.createAddress(request),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() {
    return fastHandler<List<AddressResponse>, List<AddressEntity>>(
      request: () => _remoteDataSource.getAddresses(),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteAddress(String id) {
    return fastHandler<void, Unit>(
      request: () => _remoteDataSource.deleteAddress(id),
      mapper: (_) => unit,
    );
  }
}
