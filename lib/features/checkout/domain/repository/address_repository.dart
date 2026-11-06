import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/address_request.dart';
import '../model/address_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, AddressEntity>> createAddress(AddressRequest request);
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
  Future<Either<Failure, Unit>> deleteAddress(String id);
}
