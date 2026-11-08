import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/network/failure_message.dart';
import '../../../../core/shared/data/request/products_request.dart';
import '../../../../core/shared/domain/usecase/get_products_usecase.dart';
import 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final GetProductsUseCase getProductsUseCase;
  final String categoryId;
  final String? categoryTitle;
  final RefreshController refreshController = RefreshController();

  static const int _pageSize = 10;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  ProductsByCategoryCubit({
    required this.getProductsUseCase,
    required this.categoryId,
    this.categoryTitle,
  }) : super(const ProductsByCategoryLoading());

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  Future<void> getProductsByCategory({bool isRefresh = false}) async {
    if (isClosed) return;

    if (isRefresh) {
      _currentPage = 1;
    } else {
      emit(const ProductsByCategoryLoading());
    }

    final effectiveCategory = categoryId.isNotEmpty
        ? categoryId
        : (categoryTitle ?? '');

    final result = await getProductsUseCase(
      ProductsRequest(
        category: effectiveCategory,
        page: 1,
        pageSize: _pageSize,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        if (isRefresh) {
          refreshController.refreshFailed();
        }
        emit(ProductsByCategoryError(message: failure.message));
      },
      (pageData) {
        if (isClosed) return;
        _currentPage = pageData.page;
        if (isRefresh) {
          refreshController.refreshCompleted(resetFooterState: true);
        }
        if (pageData.items.isEmpty) {
          emit(const ProductsByCategoryEmpty());
        } else {
          emit(
            ProductsByCategoryActive(
              products: pageData.items,
              page: pageData.page,
              hasNextPage: pageData.hasNextPage,
              totalCount: pageData.totalCount,
            ),
          );
        }
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isClosed || _isLoadingMore) return;

    final currentState = state;
    if (currentState is! ProductsByCategoryActive ||
        !currentState.hasNextPage) {
      refreshController.loadNoData();
      return;
    }

    _isLoadingMore = true;
    emit(currentState.copyWith(isLoadingMore: true));

    final effectiveCategory = categoryId.isNotEmpty
        ? categoryId
        : (categoryTitle ?? '');
    final nextPage = _currentPage + 1;

    final result = await getProductsUseCase(
      ProductsRequest(
        category: effectiveCategory,
        page: nextPage,
        pageSize: _pageSize,
      ),
    );

    _isLoadingMore = false;
    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        refreshController.loadFailed();
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (pageData) {
        if (isClosed) return;
        _currentPage = pageData.page;
        final updatedProducts = [...currentState.products, ...pageData.items];
        if (pageData.hasNextPage) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
        emit(
          ProductsByCategoryActive(
            products: updatedProducts,
            page: pageData.page,
            hasNextPage: pageData.hasNextPage,
            totalCount: pageData.totalCount,
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
