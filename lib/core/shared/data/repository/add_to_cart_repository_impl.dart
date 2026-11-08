import 'package:dartz/dartz.dart';

import '../../../network/error_handler/error_handler.dart';
import '../../../network/error_handler/failure.dart';
import '../../domain/model/add_to_cart_entity.dart';
import '../../domain/repository/add_to_cart_repository.dart';
import '../data_source/add_to_cart_remote_data_source.dart';
import '../mapper/add_to_cart_mapper.dart';
import '../request/add_to_cart_request.dart';
import '../response/add_to_cart_response.dart';

class AddToCartRepositoryImpl implements AddToCartRepository {
  final AddToCartRemoteDataSource _remoteDataSource;

  AddToCartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AddToCartEntity>> addToCart(AddToCartRequest request) {
    return fastHandler<AddToCartResponse, AddToCartEntity>(
      request: () => _remoteDataSource.addToCart(request),
      mapper: (response) => response.toDomain(),
    );
  }
}
