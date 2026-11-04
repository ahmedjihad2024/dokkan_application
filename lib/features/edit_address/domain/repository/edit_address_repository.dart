import 'package:dartz/dartz.dart';
import 'package:dokkan/features/checkout/domain/model/address_entity.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/edit_address_request.dart';

abstract class EditAddressRepository {
  Future<Either<Failure, AddressEntity>> updateAddress(
    String id,
    EditAddressRequest request,
  );
  Future<Either<Failure, AddressEntity>> getAddressById(String id);
  Future<Either<Failure, AddressEntity>> createAddress(
    EditAddressRequest request,
  );
}
