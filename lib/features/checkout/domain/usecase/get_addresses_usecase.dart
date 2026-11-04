import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../model/address_entity.dart';
import '../repository/address_repository.dart';

class GetAddressesUseCase {
  final AddressRepository _repository;

  GetAddressesUseCase(this._repository);

  Future<Either<Failure, List<AddressEntity>>> call() {
    return _repository.getAddresses();
  }
}

