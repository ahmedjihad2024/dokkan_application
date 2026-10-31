import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/request_state.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/data/repositories/home_repository.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final HomeRepository _repository;

  LayoutCubit({HomeRepository? repository})
      : _repository = repository ?? HomeRepositoryImpl(),
        super(const LayoutState()) {
    loadHomeData();
  }

  Future<void> loadHomeData({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(state.copyWith(status: ReqState.loading));
    }
    try {
      final banners = await _repository.getPromoBanners();
      final categories = await _repository.getCategories();
      final products = await _repository.getCuratedArrivals();

      if (banners.isEmpty && categories.isEmpty && products.isEmpty) {
        emit(state.copyWith(status: ReqState.empty));
        return;
      }

      emit(
        state.copyWith(
          status: ReqState.success,
          banners: banners,
          categories: categories,
          products: products,
        ),
      );
    } catch (e) {
      if (!isRefresh) {
        emit(
          state.copyWith(status: ReqState.failure, errorMessage: e.toString()),
        );
      }
    }
  }

  void selectCategory(String categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
  }

  void updateBannerIndex(int index) {
    emit(state.copyWith(activeBannerIndex: index));
  }

  void setNavIndex(int index) {
    emit(state.copyWith(currentNavIndex: index));
  }

  void toggleFavorite(String productId) {
    final updatedProducts = state.products.map((product) {
      if (product.id == productId) {
        return product.copyWith(isFavorite: !product.isFavorite);
      }
      return product;
    }).toList();

    emit(state.copyWith(products: updatedProducts));
  }

  void addToCart(ProductModel product) {
    emit(state.copyWith(cartCount: state.cartCount + 1));
  }
}

