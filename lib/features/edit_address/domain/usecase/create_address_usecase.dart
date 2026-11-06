import 'package:dartz/dartz.dart';
import 'package:dokkan/features/checkout/domain/model/address_entity.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/edit_address_request.dart';
import '../repository/edit_address_repository.dart';

class CreateAddressUseCase {
  final EditAddressRepository _repository;

  CreateAddressUseCase(this._repository);

  Future<Either<Failure, AddressEntity>> call(EditAddressRequest request) {
    return _repository.createAddress(request);
  }
}
