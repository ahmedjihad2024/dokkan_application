import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../model/category_entity.dart';
import '../repository/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return _repository.getCategories();
  }
}

