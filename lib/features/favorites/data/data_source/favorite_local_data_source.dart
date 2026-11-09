import '../database/favorite_db_service.dart';
import '../response/response.dart';

abstract class FavoriteLocalDataSource {
  Future<Favorite> addToFavorite(Favorite favorite);
  Future<Favorite?> removeFromFavorite(String id);
  List<Favorite> getFavorites();
  bool isFavorite(String id);
  Future<int> clearAll();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final FavoriteDbService _dbService;

  const FavoriteLocalDataSourceImpl(this._dbService);

  @override
  Future<Favorite> addToFavorite(Favorite favorite) =>
      _dbService.addToFavorite(favorite);

  @override
  Future<Favorite?> removeFromFavorite(String id) =>
      _dbService.removeFromFavorite(id);

  @override
  List<Favorite> getFavorites() => _dbService.getFavorites();

  @override
  bool isFavorite(String id) => _dbService.isFavorite(id);

  @override
  Future<int> clearAll() => _dbService.clearAll();
}
