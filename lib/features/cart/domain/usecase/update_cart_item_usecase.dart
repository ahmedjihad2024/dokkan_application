import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/update_cart_item_request.dart';
import '../model/cart_item_action_entity.dart';
import '../repository/cart_repository.dart';

class UpdateCartItemUseCase {
  final CartRepository repository;

  UpdateCartItemUseCase(this.repository);

  Future<Either<Failure, CartItemActionEntity>> call(
    UpdateCartItemRequest request,
  ) {
    return repository.updateCartItem(request);
  }
}
