enum ProductSortBy {
  price('price'),
  name('name'),
  rating('rating'),
  createdAt('createdAt'),
  discountPercentage('discountPercentage');

  final String value;
  const ProductSortBy(this.value);
}

enum ProductSortOrder {
  asc('asc'),
  desc('desc');

  final String value;
  const ProductSortOrder(this.value);
}

class ProductsRequest {
  final String? searchTerm;
  final String? category;
  final num? minPrice;
  final num? maxPrice;
  final bool? isInStock;
  final dynamic sortBy; // Accepts ProductSortBy or String
  final dynamic sortOrder; // Accepts ProductSortOrder or String
  final int page;
  final int pageSize;

  const ProductsRequest({
    this.searchTerm,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.isInStock,
    this.sortBy,
    this.sortOrder,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toQueryParameters() {
    String? resolvedSortBy;
    if (sortBy is ProductSortBy) {
      resolvedSortBy = (sortBy as ProductSortBy).value;
    } else if (sortBy is String && (sortBy as String).isNotEmpty) {
      resolvedSortBy = sortBy as String;
    }

    String? resolvedSortOrder;
    if (sortOrder is ProductSortOrder) {
      resolvedSortOrder = (sortOrder as ProductSortOrder).value;
    } else if (sortOrder is String && (sortOrder as String).isNotEmpty) {
      resolvedSortOrder = sortOrder as String;
    }

    return {
      if (searchTerm != null && searchTerm!.trim().isNotEmpty)
        'searchTerm': searchTerm!.trim(),
      if (category != null && category!.trim().isNotEmpty)
        'category': category!.trim(),
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
      if (isInStock != null) 'isInStock': isInStock,
      if (resolvedSortBy != null) 'sortBy': resolvedSortBy,
      if (resolvedSortOrder != null) 'sortOrder': resolvedSortOrder,
      'page': page,
      'pageSize': pageSize,
    };
  }

  Map<String, dynamic> toJson() => toQueryParameters();

  ProductsRequest copyWith({
    String? searchTerm,
    String? category,
    num? minPrice,
    num? maxPrice,
    bool? isInStock,
    dynamic sortBy,
    dynamic sortOrder,
    int? page,
    int? pageSize,
  }) {
    return ProductsRequest(
      searchTerm: searchTerm ?? this.searchTerm,
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      isInStock: isInStock ?? this.isInStock,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  String toString() =>
      'ProductsRequest(page: $page, pageSize: $pageSize, category: $category, searchTerm: $searchTerm, sortBy: $sortBy, sortOrder: $sortOrder)';
}

