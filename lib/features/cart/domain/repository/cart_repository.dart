import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/add_cart_item_request.dart';
import '../../data/request/decrement_cart_item_request.dart';
import '../../data/request/update_cart_item_request.dart';
import '../model/cart_entity.dart';
import '../model/cart_item_action_entity.dart';
import '../model/decrement_cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart();
  Future<Either<Failure, CartItemActionEntity>> addCartItem(
    AddCartItemRequest request,
  );
  Future<Either<Failure, CartItemActionEntity>> updateCartItem(
    UpdateCartItemRequest request,
  );
  Future<Either<Failure, DecrementCartItemEntity>> decrementCartItem(
    DecrementCartItemRequest request,
  );
  Future<Either<Failure, Unit>> deleteCartItem(String itemId);
}
