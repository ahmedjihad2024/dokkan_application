import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../repository/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repository;

  const ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, bool>> call(ProductEntity product) {
    return repository.toggleFavorite(product);
  }
}

