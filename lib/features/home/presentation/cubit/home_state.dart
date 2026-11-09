import '../../../../core/shared/domain/model/product_entity.dart';
import '../../domain/model/offer_entity.dart';

abstract class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  final List<OfferEntity> offers;
  final List<ProductEntity> products;
  final Set<String> favoriteIds;

  const HomeSuccess({
    this.offers = const [],
    this.products = const [],
    this.favoriteIds = const {},
  });

  HomeSuccess copyWith({
    List<OfferEntity>? offers,
    List<ProductEntity>? products,
    Set<String>? favoriteIds,
  }) {
    return HomeSuccess(
      offers: offers ?? this.offers,
      products: products ?? this.products,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  String toString() =>
      'HomeSuccess(offers: ${offers.length}, products: ${products.length}, favorites: ${favoriteIds.length})';
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  String toString() => 'HomeError(message: $message)';
}
