import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../repository/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<Either<Failure, Unit>> call(String id) {
    return _repository.deleteProduct(id);
  }
}

