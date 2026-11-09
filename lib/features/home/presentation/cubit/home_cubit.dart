import 'package:dokkan/core/events/app_event_bus.dart';
import 'package:dokkan/core/events/event_bus_mixin.dart';
import 'package:dokkan/core/network/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/data/request/add_to_cart_request.dart';
import '../../../../core/shared/data/request/products_request.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/usecase/add_to_cart_usecase.dart';
import '../../../../core/shared/domain/usecase/get_products_usecase.dart';
import '../../../../core/utils/wait_fails_fast.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../data/request/offers_request.dart';
import '../../domain/model/offer_entity.dart';
import '../../domain/usecase/get_offers_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with EventBusMixin {
  final GetOffersUseCase getOffersUseCase;
  final GetProductsUseCase getProductsUseCase;
  final AddToCartUseCase addToCartUseCase;

  HomeCubit({
    required this.getOffersUseCase,
    required this.getProductsUseCase,
    required this.addToCartUseCase,
  }) : super(const HomeLoading()) {
    subscribe<ProductFavoriteChanged>(_onFavoriteChanged);
  }

  void _onFavoriteChanged(ProductFavoriteChanged e) {
    final current = state;
    if (current is! HomeSuccess) return;
    emit(current.copyWith(offers: [...current.offers]));
  }

  Future<void> init() async {
    emit(const HomeLoading());

    final result = await waitFailFast([
      getOffersUseCase(const OffersRequest(page: 1, pageSize: 10)),
      getProductsUseCase(const ProductsRequest(page: 1, pageSize: 10)),
    ]);

    result.fold((failure) => emit(HomeError(message: failure.message)), (data) {
      final offers = (data[0] as OffersPaginationEntity).items;
      final products = (data[1] as ProductsPaginationEntity).items;

      emit(HomeSuccess(offers: offers, products: products));
    });
  }

  Future<void> getOffers({int page = 1, int pageSize = 10}) async {
    final result = await getOffersUseCase(
      OffersRequest(page: page, pageSize: pageSize),
    );

    result.fold((failure) => emit(HomeError(message: failure.message)), (data) {
      if (state is HomeSuccess) {
        emit((state as HomeSuccess).copyWith(offers: data.items));
      } else {
        emit(HomeSuccess(offers: data.items));
      }
    });
  }

  Future<void> getProducts(ProductsRequest request) async {
    final result = await getProductsUseCase(request);

    result.fold((failure) => emit(HomeError(message: failure.message)), (data) {
      if (state is HomeSuccess) {
        emit((state as HomeSuccess).copyWith(products: data.items));
      } else {
        emit(HomeSuccess(products: data.items));
      }
    });
  }

  Future<void> addToCart(
    String productId, {
    int quantity = 1,
    BuildContext? context,
  }) async {
    final result = await addToCartUseCase(
      AddToCartRequest(productId: productId, quantity: quantity),
    );

    result.fold(
      (failure) {
        if (context != null && context.mounted) {
          CustomSnackBar.showError(context, failure.message);
        }
      },
      (cartEntity) {
        if (context != null && context.mounted) {
          CustomSnackBar.showSuccess(
            context,
            cartEntity.message.isNotEmpty
                ? cartEntity.message
                : 'Item added to cart',
          );
        }
      },
    );
  }
}
