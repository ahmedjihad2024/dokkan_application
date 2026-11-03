import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/add_to_cart_request.dart';
import '../model/add_to_cart_entity.dart';
import '../repository/add_to_cart_repository.dart';

class AddToCartUseCase {
  final AddToCartRepository repository;

  AddToCartUseCase(this.repository);

  Future<Either<Failure, AddToCartEntity>> call(AddToCartRequest request) {
    return repository.addToCart(request);
  }
}

