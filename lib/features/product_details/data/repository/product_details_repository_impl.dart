import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../domain/repository/product_details_repository.dart';
import '../data_source/product_details_remote_data_source.dart';
import '../mapper/product_details_mapper.dart';
import '../response/product_details_response.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource _remoteDataSource;

  ProductDetailsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(String id) {
    return fastHandler<ProductDetailsResponse, ProductEntity>(
      request: () => _remoteDataSource.getProductDetails(id),
      mapper: (response) => response.toDomain(),
    );
  }
}

