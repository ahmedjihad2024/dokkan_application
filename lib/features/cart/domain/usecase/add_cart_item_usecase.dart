import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/add_cart_item_request.dart';
import '../model/cart_item_action_entity.dart';
import '../repository/cart_repository.dart';

class AddCartItemUseCase {
  final CartRepository repository;

  AddCartItemUseCase(this.repository);

  Future<Either<Failure, CartItemActionEntity>> call(
    AddCartItemRequest request,
  ) {
    return repository.addCartItem(request);
  }
}
