import '../../../../core/shared/data/request/products_request.dart';
import '../../../../core/shared/domain/model/product_entity.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchActive extends SearchState {
  final List<ProductEntity> products;
  final int page;
  final int totalCount;
  final bool hasNextPage;
  final bool isLoadingMore;

  final String? searchTerm;
  final num? minPrice;
  final num? maxPrice;
  final ProductSortBy? sortBy;
  final ProductSortOrder? sortOrder;
  final bool isFilterPanelOpen;
  final Set<String> favoriteIds;

  const SearchActive({
    required this.products,
    required this.page,
    required this.totalCount,
    required this.hasNextPage,
    this.isLoadingMore = false,
    this.searchTerm,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
    this.sortOrder,
    this.isFilterPanelOpen = false,
    this.favoriteIds = const {},
  });

  int get activeFiltersCount {
    int count = 0;
    if (minPrice != null) count++;
    if (maxPrice != null) count++;
    if (sortBy != null) count++;
    if (sortOrder != null) count++;
    return count;
  }

  SearchActive copyWith({
    List<ProductEntity>? products,
    int? page,
    int? totalCount,
    bool? hasNextPage,
    bool? isLoadingMore,
    String? searchTerm,
    num? minPrice,
    num? maxPrice,
    ProductSortBy? sortBy,
    ProductSortOrder? sortOrder,
    bool? isFilterPanelOpen,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
    bool clearSortBy = false,
    bool clearSortOrder = false,
    Set<String>? favoriteIds,
  }) {
    return SearchActive(
      products: products ?? this.products,
      page: page ?? this.page,
      totalCount: totalCount ?? this.totalCount,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchTerm: searchTerm ?? this.searchTerm,
      minPrice: clearMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearMaxPrice ? null : (maxPrice ?? this.maxPrice),
      sortBy: clearSortBy ? null : (sortBy ?? this.sortBy),
      sortOrder: clearSortOrder ? null : (sortOrder ?? this.sortOrder),
      isFilterPanelOpen: isFilterPanelOpen ?? this.isFilterPanelOpen,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

class SearchEmpty extends SearchState {
  final String? searchTerm;
  final bool hasActiveFilters;
  final bool isFilterPanelOpen;

  const SearchEmpty({
    this.searchTerm,
    this.hasActiveFilters = false,
    this.isFilterPanelOpen = false,
  });
}

class SearchError extends SearchState {
  final String message;
  final bool isFilterPanelOpen;

  const SearchError({
    required this.message,
    this.isFilterPanelOpen = false,
  });
}

