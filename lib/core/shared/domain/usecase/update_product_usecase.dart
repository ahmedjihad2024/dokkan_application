import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/update_product_request.dart';
import '../model/product_entity.dart';
import '../repository/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository _repository;

  UpdateProductUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(UpdateProductRequest request) {
    return _repository.updateProduct(request);
  }
}

