import 'package:dartz/dartz.dart';

import '../../../network/error_handler/error_handler.dart';
import '../../../network/error_handler/failure.dart';
import '../../domain/model/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_remote_data_source.dart';
import '../mapper/product_mapper.dart';
import '../request/products_request.dart';
import '../response/products_response.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ProductsPaginationEntity>> getProducts(
    ProductsRequest request,
  ) {
    return fastHandler<ProductsResponse, ProductsPaginationEntity>(
      request: () => _remoteDataSource.getProducts(request),
      mapper: (response) => response.toDomain(),
    );
  }
}

