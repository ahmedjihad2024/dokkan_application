import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../repository/cart_repository.dart';

class DeleteCartItemUseCase {
  final CartRepository repository;

  DeleteCartItemUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String itemId) {
    return repository.deleteCartItem(itemId);
  }
}
