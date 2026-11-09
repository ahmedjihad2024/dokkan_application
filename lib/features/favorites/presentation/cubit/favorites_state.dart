import '../../../../core/shared/domain/model/product_entity.dart';

sealed class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoaded extends FavoritesState {
  final List<ProductEntity> products;

  const FavoritesLoaded(this.products);
}

class FavoritesEmpty extends FavoritesState {
  const FavoritesEmpty();
}

