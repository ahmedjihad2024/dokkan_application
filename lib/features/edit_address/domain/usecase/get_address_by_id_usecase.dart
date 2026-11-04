import 'package:dartz/dartz.dart';
import 'package:dokkan/features/checkout/domain/model/address_entity.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../repository/edit_address_repository.dart';

class GetAddressByIdUseCase {
  final EditAddressRepository _repository;

  GetAddressByIdUseCase(this._repository);

  Future<Either<Failure, AddressEntity>> call(String id) {
    return _repository.getAddressById(id);
  }
}
