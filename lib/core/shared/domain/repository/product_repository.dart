import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/products_request.dart';
import '../model/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsPaginationEntity>> getProducts(
    ProductsRequest request,
  );
}

