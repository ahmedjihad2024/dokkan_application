import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../repository/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  const GetFavoritesUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getFavorites();
  }
}
