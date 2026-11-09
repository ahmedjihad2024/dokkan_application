import 'package:dokkan/features/favorites/data/response/response.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

abstract class FavoriteDbService {
  Future<Favorite> addToFavorite(Favorite favorite);
  Future<Favorite?> removeFromFavorite(String id);
  List<Favorite> getFavorites();
  bool isFavorite(String id);
  Future<int> clearAll();
}

class FavoriteDbServiceImpl implements FavoriteDbService {
  final Box<Favorite> _box;

  FavoriteDbServiceImpl(this._box);

  @override
  Future<Favorite> addToFavorite(Favorite favorite) async {
    await _box.put(favorite.id, favorite);
    return favorite;
  }

  @override
  Future<Favorite?> removeFromFavorite(String id) async {
    final Favorite? fav = _box.get(id);
    await _box.delete(id);
    return fav;
  }

  @override
  List<Favorite> getFavorites() {
    return _box.values.toList();
  }

  @override
  bool isFavorite(String id) {
    return _box.containsKey(id);
  }

  @override
  Future<int> clearAll() async => await _box.clear();
}
