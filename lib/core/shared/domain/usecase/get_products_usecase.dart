import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/products_request.dart';
import '../model/product_entity.dart';
import '../repository/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Either<Failure, ProductsPaginationEntity>> call(
    ProductsRequest request,
  ) {
    return _repository.getProducts(request);
  }
}

