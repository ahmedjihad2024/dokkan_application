import 'package:dokkan/core/network/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/data/request/add_to_cart_request.dart';
import '../../../../core/shared/data/request/reviews_request.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/model/review_entity.dart';
import '../../../../core/shared/domain/usecase/add_to_cart_usecase.dart';
import '../../../../core/shared/domain/usecase/get_reviews_usecase.dart';
import '../../../../core/utils/wait_fails_fast.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../domain/usecase/get_product_details_usecase.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final GetReviewsUseCase getReviewsUseCase;
  final AddToCartUseCase addToCartUseCase;

  int _quantity = 1;
  int get quantity => _quantity;

  ProductDetailsCubit({
    required this.getProductDetailsUseCase,
    required this.getReviewsUseCase,
    required this.addToCartUseCase,
  }) : super(const ProductDetailsInitial());

  Future<void> getProductDetails(String productId) => init(productId);

  Future<void> init(String productId) async {
    _quantity = 1;
    emit(const ProductDetailsLoading());

    final result = await waitFailFast([
      getProductDetailsUseCase(productId),
      getReviewsUseCase(productId, const ReviewsRequest(page: 1, pageSize: 2)),
    ]);

    result.fold(
      (failure) => emit(ProductDetailsError(message: failure.message)),
      (data) {
        final product = data[0] as ProductEntity;
        final reviews = data[1] as List<ReviewEntity>;

        emit(
          ProductDetailsSuccess(
            product: product,
            reviews: reviews.take(2).toList(),
            averageRating: product.rating,
            reviewsCount: product.reviewsCount,
            quantity: _quantity,
          ),
        );
      },
    );
  }

  void incrementQuantity(int maxStock, BuildContext context) {
    if (_quantity < maxStock) {
      _quantity++;
      if (state is ProductDetailsSuccess) {
        emit((state as ProductDetailsSuccess).copyWith(quantity: _quantity));
      }
    } else {
      CustomSnackBar.showWarning(context, 'Only $maxStock left in stock');
    }
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      if (state is ProductDetailsSuccess) {
        emit((state as ProductDetailsSuccess).copyWith(quantity: _quantity));
      }
    }
  }

  Future<void> addToCart(
    String productId,
    int quantity,
    BuildContext context,
  ) async {
    if (state is! ProductDetailsSuccess) return;
    final currentSuccess = state as ProductDetailsSuccess;

    emit(currentSuccess.copyWith(isAddingToCart: true));

    final result = await addToCartUseCase.call(
      AddToCartRequest(productId: productId, quantity: quantity),
    );

    result.fold(
      (failure) {
        emit(currentSuccess.copyWith(isAddingToCart: false));
        CustomSnackBar.showError(context, failure.message);
      },
      (data) {
        emit(currentSuccess.copyWith(isAddingToCart: false));
        CustomSnackBar.showSuccess(
          context,
          data.message.isNotEmpty
              ? data.message
              : 'Item added to cart successfully.',
        );
      },
    );
  }

  Future<void> addToCard(
    String productId,
    int quantity,
    BuildContext context,
  ) =>
      addToCart(productId, quantity, context);
}
