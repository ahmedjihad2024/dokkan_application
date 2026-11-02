import '../../../../core/shared/domain/model/category_entity.dart';
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
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;

  const HomeSuccess({
    this.offers = const [],
    this.categories = const [],
    this.products = const [],
  });

  HomeSuccess copyWith({
    List<OfferEntity>? offers,
    List<CategoryEntity>? categories,
    List<ProductEntity>? products,
  }) {
    return HomeSuccess(
      offers: offers ?? this.offers,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  @override
  String toString() =>
      'HomeSuccess(offers: ${offers.length}, categories: ${categories.length}, products: ${products.length})';
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  String toString() => 'HomeError(message: $message)';
}
