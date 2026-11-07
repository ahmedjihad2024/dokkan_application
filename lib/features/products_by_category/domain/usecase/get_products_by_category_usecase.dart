import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/products_by_category_request.dart';
import '../model/products_by_category_entity.dart';
import '../repository/products_by_category_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductsByCategoryRepository _repository;

  GetProductsByCategoryUseCase(this._repository);

  Future<Either<Failure, ProductsByCategoryPageEntity>> call(
    ProductsByCategoryRequest request,
  ) {
    return _repository.getProductsByCategory(request);
  }
}

