import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../repository/favorites_repository.dart';

class IsFavoriteUseCase {
  final FavoritesRepository repository;

  const IsFavoriteUseCase(this.repository);

  Either<Failure, bool> call(String productId) {
    return repository.isFavorite(productId);
  }
}

