import 'package:dokkan/core/network/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/data/request/add_to_cart_request.dart';
import '../../../../core/shared/data/request/products_request.dart';
import '../../../../core/shared/domain/model/category_entity.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/usecase/add_to_cart_usecase.dart';
import '../../../../core/shared/domain/usecase/get_categories_usecase.dart';
import '../../../../core/shared/domain/usecase/get_products_usecase.dart';
import '../../../../core/utils/wait_fails_fast.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../data/request/offers_request.dart';
import '../../domain/model/offer_entity.dart';
import '../../domain/usecase/get_offers_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetOffersUseCase getOffersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final AddToCartUseCase addToCartUseCase;

  HomeCubit({
    required this.getOffersUseCase,
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
    required this.addToCartUseCase,
  }) : super(const HomeLoading());

  Future<void> init() async {
    emit(const HomeLoading());

    final result = await waitFailFast([
      getOffersUseCase(const OffersRequest(page: 1, pageSize: 10)),
      getCategoriesUseCase(),
      getProductsUseCase(const ProductsRequest(page: 1, pageSize: 10)),
    ]);

    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (data) {
        final offers = (data[0] as OffersPaginationEntity).items;
        final categories = data[1] as List<CategoryEntity>;
        final products = (data[2] as ProductsPaginationEntity).items;

        emit(HomeSuccess(
          offers: offers,
          categories: categories,
          products: products,
        ));
      },
    );
  }

  Future<void> getOffers({int page = 1, int pageSize = 10}) async {
    final result = await getOffersUseCase(
      OffersRequest(page: page, pageSize: pageSize),
    );

    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (data) {
        if (state is HomeSuccess) {
          emit((state as HomeSuccess).copyWith(offers: data.items));
        } else {
          emit(HomeSuccess(offers: data.items));
        }
      },
    );
  }

  Future<void> getCategories() async {
    final result = await getCategoriesUseCase();

    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (data) {
        if (state is HomeSuccess) {
          emit((state as HomeSuccess).copyWith(categories: data));
        } else {
          emit(HomeSuccess(categories: data));
        }
      },
    );
  }

  Future<void> getProducts(ProductsRequest request) async {
    final result = await getProductsUseCase(request);

    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (data) {
        if (state is HomeSuccess) {
          emit((state as HomeSuccess).copyWith(products: data.items));
        } else {
          emit(HomeSuccess(products: data.items));
        }
      },
    );
  }

  Future<void> addToCart(
    String productId, {
    int quantity = 1,
    BuildContext? context,
  }) async {
    final result = await addToCartUseCase.call(
      AddToCartRequest(productId: productId, quantity: quantity),
    );

    result.fold(
      (failure) {
        if (context != null) {
          CustomSnackBar.showError(context, failure.message);
        }
      },
      (data) {
        if (context != null) {
          CustomSnackBar.showSuccess(
            context,
            data.message.isNotEmpty
                ? data.message
                : 'Item added to cart successfully.',
          );
        }
      },
    );
  }

  Future<void> addToCard(
    String productId, {
    int quantity = 1,
    BuildContext? context,
  }) =>
      addToCart(productId, quantity: quantity, context: context);
}
