import 'package:dartz/dartz.dart';
import 'package:dokkan/features/checkout/domain/model/address_entity.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/edit_address_request.dart';
import '../repository/edit_address_repository.dart';

class UpdateAddressUseCase {
  final EditAddressRepository _repository;

  UpdateAddressUseCase(this._repository);

  Future<Either<Failure, AddressEntity>> call(
    String id,
    EditAddressRequest request,
  ) {
    return _repository.updateAddress(id, request);
  }
}
