import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/products_by_category_request.dart';
import '../model/products_by_category_entity.dart';

abstract class ProductsByCategoryRepository {
  Future<Either<Failure, ProductsByCategoryPageEntity>> getProductsByCategory(
    ProductsByCategoryRequest request,
  );
}

