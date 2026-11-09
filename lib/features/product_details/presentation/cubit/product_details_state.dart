import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/model/review_entity.dart';

abstract class ProductDetailsState {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductEntity product;
  final List<ReviewEntity> reviews;
  final double averageRating;
  final int reviewsCount;
  final int quantity;
  final bool isAddingToCart;
  final bool isFavorite;

  const ProductDetailsSuccess({
    required this.product,
    this.reviews = const [],
    required this.averageRating,
    required this.reviewsCount,
    this.quantity = 1,
    this.isAddingToCart = false,
    this.isFavorite = false,
  });

  ProductDetailsSuccess copyWith({
    ProductEntity? product,
    List<ReviewEntity>? reviews,
    double? averageRating,
    int? reviewsCount,
    int? quantity,
    bool? isAddingToCart,
    bool? isFavorite,
  }) {
    return ProductDetailsSuccess(
      product: product ?? this.product,
      reviews: reviews ?? this.reviews,
      averageRating: averageRating ?? this.averageRating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      quantity: quantity ?? this.quantity,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() =>
      'ProductDetailsSuccess(product: ${product.name}, quantity: $quantity, isFavorite: $isFavorite)';
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError({required this.message});

  @override
  String toString() => 'ProductDetailsError(message: $message)';
}
