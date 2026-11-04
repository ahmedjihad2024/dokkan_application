import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../domain/model/cart_entity.dart';
import '../../domain/model/cart_item_action_entity.dart';
import '../../domain/model/decrement_cart_item_entity.dart';
import '../../domain/repository/cart_repository.dart';
import '../data_source/cart_remote_data_source.dart';
import '../mapper/cart_mapper.dart';
import '../request/add_cart_item_request.dart';
import '../request/decrement_cart_item_request.dart';
import '../request/update_cart_item_request.dart';
import '../response/cart_item_action_response.dart';
import '../response/decrement_cart_item_response.dart';
import '../response/delete_cart_item_response.dart';
import '../response/get_cart_response.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CartEntity>> getCart() {
    return fastHandler<GetCartResponse, CartEntity>(
      request: () => _remoteDataSource.getCart(),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, CartItemActionEntity>> addCartItem(
    AddCartItemRequest request,
  ) {
    return fastHandler<CartItemActionResponse, CartItemActionEntity>(
      request: () => _remoteDataSource.addCartItem(request),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, CartItemActionEntity>> updateCartItem(
    UpdateCartItemRequest request,
  ) {
    return fastHandler<CartItemActionResponse, CartItemActionEntity>(
      request: () => _remoteDataSource.updateCartItem(request),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, DecrementCartItemEntity>> decrementCartItem(
    DecrementCartItemRequest request,
  ) {
    return fastHandler<DecrementCartItemResponse, DecrementCartItemEntity>(
      request: () => _remoteDataSource.decrementCartItem(request),
      mapper: (response) => response.toDomain(),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteCartItem(String itemId) {
    return fastHandler<DeleteCartItemResponse, Unit>(
      request: () => _remoteDataSource.deleteCartItem(itemId),
      mapper: (response) => unit,
    );
  }
}
