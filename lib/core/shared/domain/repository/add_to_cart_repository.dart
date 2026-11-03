import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/add_to_cart_request.dart';
import '../model/add_to_cart_entity.dart';

abstract class AddToCartRepository {
  Future<Either<Failure, AddToCartEntity>> addToCart(AddToCartRequest request);
}

