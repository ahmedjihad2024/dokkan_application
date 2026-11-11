import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/create_product_request.dart';
import '../model/product_entity.dart';
import '../repository/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository _repository;

  CreateProductUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(CreateProductRequest request) {
    return _repository.createProduct(request);
  }
}

