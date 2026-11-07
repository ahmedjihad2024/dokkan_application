import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../domain/model/products_by_category_entity.dart';
import '../../domain/repository/products_by_category_repository.dart';
import '../data_source/products_by_category_remote_data_source.dart';
import '../mapper/products_by_category_mapper.dart';
import '../request/products_by_category_request.dart';
import '../response/products_by_category_response.dart';

class ProductsByCategoryRepositoryImpl implements ProductsByCategoryRepository {
  final ProductsByCategoryRemoteDataSource _remoteDataSource;

  ProductsByCategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ProductsByCategoryPageEntity>> getProductsByCategory(
    ProductsByCategoryRequest request,
  ) {
    return fastHandler<ProductsByCategoryResponse, ProductsByCategoryPageEntity>(
      request: () => _remoteDataSource.getProductsByCategory(request),
      mapper: (response) => response.toDomain(),
    );
  }
}
