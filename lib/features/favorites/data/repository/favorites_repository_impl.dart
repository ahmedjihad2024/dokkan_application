import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../domain/repository/favorites_repository.dart';
import '../data_source/favorite_local_data_source.dart';
import '../mapper/favorite_mapper.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoriteLocalDataSource _localDataSource;

  const FavoritesRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, ProductEntity>> addToFavorites(ProductEntity product) async {
    try {
      final favorite = product.toFavorite();
      final savedFavorite = await _localDataSource.addToFavorite(favorite);
      return Right(savedFavorite.toDomain());
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavorites(String productId) async {
    try {
      await _localDataSource.removeFromFavorite(productId);
      return const Right(unit);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavorites() async {
    try {
      final favorites = _localDataSource.getFavorites();
      final products = favorites.map((f) => f.toDomain()).toList();
      return Right(products);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Either<Failure, bool> isFavorite(String productId) {
    try {
      final result = _localDataSource.isFavorite(productId);
      return Right(result);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(ProductEntity product) async {
    try {
      final isFav = _localDataSource.isFavorite(product.id);
      if (isFav) {
        await _localDataSource.removeFromFavorite(product.id);
        return const Right(false);
      } else {
        await _localDataSource.addToFavorite(product.toFavorite());
        return const Right(true);
      }
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearFavorites() async {
    try {
      await _localDataSource.clearAll();
      return const Right(unit);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }
}
