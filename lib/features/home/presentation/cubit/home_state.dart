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

  const HomeSuccess({
    this.offers = const [],
    this.products = const [],
  });

  HomeSuccess copyWith({
    List<OfferEntity>? offers,
    List<ProductEntity>? products,
  }) {
    return HomeSuccess(
      offers: offers ?? this.offers,
      products: products ?? this.products,
    );
  }

  @override
  String toString() =>
      'HomeSuccess(offers: ${offers.length}, products: ${products.length})';
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  String toString() => 'HomeError(message: $message)';
}
