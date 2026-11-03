import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/decrement_cart_item_request.dart';
import '../model/decrement_cart_item_entity.dart';
import '../repository/cart_repository.dart';

class DecrementCartItemUseCase {
  final CartRepository repository;

  DecrementCartItemUseCase(this.repository);

  Future<Either<Failure, DecrementCartItemEntity>> call(
    DecrementCartItemRequest request,
  ) {
    return repository.decrementCartItem(request);
  }
}

