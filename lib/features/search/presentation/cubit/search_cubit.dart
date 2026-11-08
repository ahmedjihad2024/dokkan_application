import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/network/failure_message.dart';
import '../../../../core/shared/data/request/add_to_cart_request.dart';
import '../../../../core/shared/data/request/products_request.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/usecase/add_to_cart_usecase.dart';
import '../../../../core/shared/domain/usecase/get_products_usecase.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetProductsUseCase getProductsUseCase;
  final AddToCartUseCase addToCartUseCase;

  final RefreshController refreshController = RefreshController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  static const int _pageSize = 20;
  int _currentPage = 1;
  bool _isLoadingMore = false;
  Timer? _debounceTimer;

  // Filter and search parameters
  String? _searchTerm;
  num? _minPrice;
  num? _maxPrice;
  ProductSortBy? _sortBy;
  ProductSortOrder? _sortOrder;
  bool _isFilterPanelOpen = false;

  SearchCubit({
    required this.getProductsUseCase,
    required this.addToCartUseCase,
  }) : super(const SearchInitial());

  String? get searchTerm => _searchTerm;
  num? get minPrice => _minPrice;
  num? get maxPrice => _maxPrice;
  ProductSortBy? get sortBy => _sortBy;
  ProductSortOrder? get sortOrder => _sortOrder;
  bool get isFilterPanelOpen => _isFilterPanelOpen;

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    refreshController.dispose();
    searchController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    return super.close();
  }

  void toggleFilterPanel() {
    _isFilterPanelOpen = !_isFilterPanelOpen;
    _emitUpdatedPanelState();
  }

  void closeFilterPanel() {
    if (_isFilterPanelOpen) {
      _isFilterPanelOpen = false;
      _emitUpdatedPanelState();
    }
  }

  void _emitUpdatedPanelState() {
    final current = state;
    if (current is SearchActive) {
      emit(current.copyWith(isFilterPanelOpen: _isFilterPanelOpen));
    } else if (current is SearchEmpty) {
      emit(SearchEmpty(
        searchTerm: current.searchTerm,
        hasActiveFilters: current.hasActiveFilters,
        isFilterPanelOpen: _isFilterPanelOpen,
      ));
    } else if (current is SearchError) {
      emit(SearchError(
        message: current.message,
        isFilterPanelOpen: _isFilterPanelOpen,
      ));
    }
  }

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _searchTerm = query.trim().isEmpty ? null : query.trim();
      fetchProducts(isRefresh: true);
    });
  }

  void onSearchSubmitted(String query) {
    _debounceTimer?.cancel();
    _searchTerm = query.trim().isEmpty ? null : query.trim();
    fetchProducts(isRefresh: true);
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    searchController.clear();
    _searchTerm = null;
    fetchProducts(isRefresh: true);
  }

  void applyFilters({
    num? minPrice,
    num? maxPrice,
    ProductSortBy? sortBy,
    ProductSortOrder? sortOrder,
  }) {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _sortBy = sortBy;
    _sortOrder = sortOrder;

    if (minPrice != null) {
      minPriceController.text = minPrice.toString();
    } else {
      minPriceController.clear();
    }

    if (maxPrice != null) {
      maxPriceController.text = maxPrice.toString();
    } else {
      maxPriceController.clear();
    }

    // Auto-close filter panel on apply
    _isFilterPanelOpen = false;

    fetchProducts(isRefresh: true);
  }

  void resetFilters() {
    _minPrice = null;
    _maxPrice = null;
    _sortBy = null;
    _sortOrder = null;
    minPriceController.clear();
    maxPriceController.clear();

    fetchProducts(isRefresh: true);
  }

  void removeMinPrice() {
    _minPrice = null;
    minPriceController.clear();
    fetchProducts(isRefresh: true);
  }

  void removeMaxPrice() {
    _maxPrice = null;
    maxPriceController.clear();
    fetchProducts(isRefresh: true);
  }

  void removeSorting() {
    _sortBy = null;
    _sortOrder = null;
    fetchProducts(isRefresh: true);
  }

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isClosed) return;

    if (isRefresh) {
      _currentPage = 1;
    } else {
      emit(const SearchLoading());
    }

    final request = ProductsRequest(
      searchTerm: _searchTerm,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      sortBy: _sortBy,
      sortOrder: _sortOrder,
      page: 1,
      pageSize: _pageSize,
    );

    final result = await getProductsUseCase(request);

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        if (isRefresh) {
          refreshController.refreshFailed();
        }
        emit(SearchError(
          message: failure.message,
          isFilterPanelOpen: _isFilterPanelOpen,
        ));
      },
      (pageData) {
        if (isClosed) return;
        _currentPage = pageData.page;
        if (isRefresh) {
          refreshController.refreshCompleted(resetFooterState: true);
        }

        final hasFilters = _minPrice != null ||
            _maxPrice != null ||
            _sortBy != null ||
            _sortOrder != null;

        if (pageData.items.isEmpty) {
          emit(SearchEmpty(
            searchTerm: _searchTerm,
            hasActiveFilters: hasFilters,
            isFilterPanelOpen: _isFilterPanelOpen,
          ));
        } else {
          emit(
            SearchActive(
              products: pageData.items,
              page: pageData.page,
              hasNextPage: pageData.hasNextPage,
              totalCount: pageData.totalCount,
              searchTerm: _searchTerm,
              minPrice: _minPrice,
              maxPrice: _maxPrice,
              sortBy: _sortBy,
              sortOrder: _sortOrder,
              isFilterPanelOpen: _isFilterPanelOpen,
            ),
          );
        }
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isClosed || _isLoadingMore) return;

    final currentState = state;
    if (currentState is! SearchActive || !currentState.hasNextPage) {
      refreshController.loadNoData();
      return;
    }

    _isLoadingMore = true;
    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = _currentPage + 1;
    final request = ProductsRequest(
      searchTerm: _searchTerm,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      sortBy: _sortBy,
      sortOrder: _sortOrder,
      page: nextPage,
      pageSize: _pageSize,
    );

    final result = await getProductsUseCase(request);

    if (isClosed) return;

    _isLoadingMore = false;

    result.fold(
      (failure) {
        if (isClosed) return;
        refreshController.loadFailed();
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (pageData) {
        if (isClosed) return;
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
            hasNextPage: pageData.hasNextPage,
            totalCount: pageData.totalCount,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> addToCart(ProductEntity product, BuildContext context) async {
    final result = await addToCartUseCase(
      AddToCartRequest(productId: product.id, quantity: 1),
    );

    if (!context.mounted) return;

    result.fold(
      (failure) {
        CustomSnackBar.showError(context, failure.message);
      },
      (cartEntity) {
        CustomSnackBar.showSuccess(
          context,
          cartEntity.message.isNotEmpty
              ? cartEntity.message
              : '${product.name} added to cart',
        );
      },
    );
  }
}

