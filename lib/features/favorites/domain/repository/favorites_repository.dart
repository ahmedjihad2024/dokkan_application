import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, ProductEntity>> addToFavorites(ProductEntity product);
  Future<Either<Failure, Unit>> removeFromFavorites(String productId);
  Future<Either<Failure, List<ProductEntity>>> getFavorites();
  Either<Failure, bool> isFavorite(String productId);
  Future<Either<Failure, bool>> toggleFavorite(ProductEntity product);
  Future<Either<Failure, Unit>> clearFavorites();
}
