import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../repository/favorites_repository.dart';

class RemoveFromFavoritesUseCase {
  final FavoritesRepository repository;

  const RemoveFromFavoritesUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String productId) {
    return repository.removeFromFavorites(productId);
  }
}

