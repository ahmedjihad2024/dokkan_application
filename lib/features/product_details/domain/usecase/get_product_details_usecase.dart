import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../repository/product_details_repository.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository _repository;

  GetProductDetailsUseCase(this._repository);

  Future<Either<Failure, ProductEntity>> call(String id) {
    return _repository.getProductDetails(id);
  }
}

