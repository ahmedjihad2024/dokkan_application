import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../repository/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository _repository;

  DeleteAddressUseCase(this._repository);

  Future<Either<Failure, Unit>> call(String id) {
    return _repository.deleteAddress(id);
  }
}

