import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/network/failure_message.dart';
import '../../../../core/shared/data/request/products_request.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/usecase/delete_product_usecase.dart';
import '../../../../core/shared/domain/usecase/get_products_usecase.dart';
import 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  final RefreshController refreshController = RefreshController();

  static const int _pageSize = 20;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  ManageProductsCubit({
    required this.getProductsUseCase,
    required this.deleteProductUseCase,
  }) : super(const ManageProductsInitial());

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isClosed) return;

    final previousState = state;
    if (isRefresh) {
      _currentPage = 1;
    } else {
      emit(const ManageProductsLoading());
    }

    final result = await getProductsUseCase(
      const ProductsRequest(page: 1, pageSize: _pageSize),
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isRefresh) {
          refreshController.refreshFailed();
          if (previousState is ManageProductsActive) {
            emit(ManageProductsActionError(failure.message));
            emit(previousState);
            return;
          }
        }
        emit(ManageProductsError(message: failure.message));
      },
      (pageData) {
        _currentPage = pageData.page;
        if (isRefresh) {
          refreshController.refreshCompleted(
            resetFooterState: pageData.hasNextPage,
          );
        }
        if (!pageData.hasNextPage) {
          refreshController.loadNoData();
        }

        if (pageData.items.isEmpty) {
          emit(const ManageProductsEmpty());
        } else {
          emit(
            ManageProductsActive(
              products: pageData.items,
              page: pageData.page,
              totalCount: pageData.totalCount,
              hasNextPage: pageData.hasNextPage,
            ),
          );
        }
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isClosed || _isLoadingMore) return;

    final currentState = state;
    if (currentState is! ManageProductsActive || !currentState.hasNextPage) {
      refreshController.loadNoData();
      return;
    }

    _isLoadingMore = true;
    emit(currentState.copyWith(isLoadingMore: true));

    final result = await getProductsUseCase(
      ProductsRequest(page: _currentPage + 1, pageSize: _pageSize),
    );

    if (isClosed) return;
    _isLoadingMore = false;

    result.fold(
      (failure) {
        refreshController.loadFailed();
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (pageData) {
        _currentPage = pageData.page;
        final updatedList = List<ProductEntity>.from(currentState.products)
          ..addAll(pageData.items);

        if (!pageData.hasNextPage) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }

        emit(
          currentState.copyWith(
            products: updatedList,
            page: pageData.page,
            totalCount: pageData.totalCount,
            hasNextPage: pageData.hasNextPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> deleteProduct(String id) async {
    final currentState = state;
    if (isClosed ||
        currentState is! ManageProductsActive ||
        currentState.deletingProductId != null) {
      return;
    }

    emit(currentState.copyWith(deletingProductId: id));

    final result = await deleteProductUseCase(id);
    if (isClosed) return;

    await result.fold(
      (failure) async {
        final message = failure.message.isNotEmpty
            ? failure.message
            : 'Delete failed, please try again.';
        emit(currentState.copyWith(clearDeletingProductId: true));
        emit(ManageProductsActionError(message));
      },
      (_) async {
        final updatedList = currentState.products
            .where((product) => product.id != id)
            .toList();
        final nextTotal = currentState.totalCount > 0
            ? currentState.totalCount - 1
            : updatedList.length;

        emit(const ManageProductsActionSuccess('Product deleted successfully'));

        if (updatedList.isEmpty) {
          if (currentState.hasNextPage) {
            await fetchProducts();
          } else {
            emit(const ManageProductsEmpty());
          }
        } else {
          emit(
            currentState.copyWith(
              products: updatedList,
              totalCount: nextTotal,
              clearDeletingProductId: true,
            ),
          );
        }
      },
    );
  }
}
