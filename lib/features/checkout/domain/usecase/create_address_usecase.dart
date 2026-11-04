import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/address_request.dart';
import '../model/address_entity.dart';
import '../repository/address_repository.dart';

class CreateAddressUseCase {
  final AddressRepository _repository;

  CreateAddressUseCase(this._repository);

  Future<Either<Failure, AddressEntity>> call(AddressRequest request) {
    return _repository.createAddress(request);
  }
}

