import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../model/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}

