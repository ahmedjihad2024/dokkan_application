import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/decrement_cart_item_request.dart';
import '../model/cart_entity.dart';
import '../model/decrement_cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart();
  Future<Either<Failure, DecrementCartItemEntity>> decrementCartItem(
    DecrementCartItemRequest request,
  );
}

