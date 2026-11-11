import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/create_product_request.dart';
import '../../data/request/products_request.dart';
import '../../data/request/update_product_request.dart';
import '../model/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsPaginationEntity>> getProducts(
    ProductsRequest request,
  );

  Future<Either<Failure, ProductEntity>> createProduct(
    CreateProductRequest request,
  );

  Future<Either<Failure, ProductEntity>> updateProduct(
    UpdateProductRequest request,
  );

  Future<Either<Failure, Unit>> deleteProduct(String id);
}
