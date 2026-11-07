import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/error_handler.dart';
import '../../../../core/network/error_handler/failure.dart';
import '../../domain/model/category_entity.dart';
import '../../domain/repository/category_repository.dart';
import '../data_source/category_remote_data_source.dart';
import '../mapper/category_mapper.dart';
import '../response/categories_response.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    return fastHandler<CategoriesResponse, List<CategoryEntity>>(
      request: () => _remoteDataSource.getCategories(),
      mapper: (response) => response.toDomain(),
    );
  }
}

