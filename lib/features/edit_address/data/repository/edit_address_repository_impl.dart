import 'package:dartz/dartz.dart';
import 'package:dokkan/features/checkout/domain/model/address_entity.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../domain/repository/edit_address_repository.dart';
import '../data_source/edit_address_remote_data_source.dart';
import '../mapper/edit_address_mapper.dart';
import '../request/edit_address_request.dart';
import '../response/edit_address_response.dart';

class EditAddressRepositoryImpl implements EditAddressRepository {
  final EditAddressRemoteDataSource _remoteDataSource;

  EditAddressRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AddressEntity>> updateAddress(
    String id,
    EditAddressRequest request,
  ) {
    return fastHandler<EditAddressResponse, AddressEntity>(
      request: () => _remoteDataSource.updateAddress(id, request),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, AddressEntity>> getAddressById(String id) {
    return fastHandler<EditAddressResponse, AddressEntity>(
      request: () => _remoteDataSource.getAddressById(id),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, AddressEntity>> createAddress(
    EditAddressRequest request,
  ) {
    return fastHandler<EditAddressResponse, AddressEntity>(
      request: () => _remoteDataSource.createAddress(request),
      mapper: (response) => response.toDomain(),
    );
  }
}
