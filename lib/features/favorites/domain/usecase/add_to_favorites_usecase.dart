import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../repository/favorites_repository.dart';

class AddToFavoritesUseCase {
  final FavoritesRepository repository;

  const AddToFavoritesUseCase(this.repository);

  Future<Either<Failure, ProductEntity>> call(ProductEntity product) {
    return repository.addToFavorites(product);
  }
}

