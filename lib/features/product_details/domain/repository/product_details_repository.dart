import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductEntity>> getProductDetails(String id);
}

