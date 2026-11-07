class ProductsByCategoryRequest {
  final String categoryId;
  final int page;
  final int pageSize;

  const ProductsByCategoryRequest({
    required this.categoryId,
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      'categoryId': categoryId,
      'page': page,
      'pageSize': pageSize,
    };
  }

  Map<String, dynamic> toJson() => toQueryParameters();

  ProductsByCategoryRequest copyWith({
    String? categoryId,
    int? page,
    int? pageSize,
  }) {
    return ProductsByCategoryRequest(
      categoryId: categoryId ?? this.categoryId,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

