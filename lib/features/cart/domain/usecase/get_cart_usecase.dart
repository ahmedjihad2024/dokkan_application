import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../model/cart_entity.dart';
import '../repository/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Either<Failure, CartEntity>> call() {
    return repository.getCart();
  }
}

