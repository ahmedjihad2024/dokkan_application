import '../../../../core/shared/domain/model/product_entity.dart';

abstract class ProductsByCategoryState {
  const ProductsByCategoryState();
}

class ProductsByCategoryLoading extends ProductsByCategoryState {
  const ProductsByCategoryLoading();
}

class ProductsByCategoryActive extends ProductsByCategoryState {
  final List<ProductEntity> products;
  final int page;
  final bool hasNextPage;
  final int totalCount;
  final bool isLoadingMore;

  const ProductsByCategoryActive({
    required this.products,
    required this.page,
    required this.hasNextPage,
    required this.totalCount,
    this.isLoadingMore = false,
  });

  ProductsByCategoryActive copyWith({
    List<ProductEntity>? products,
    int? page,
    bool? hasNextPage,
    int? totalCount,
    bool? isLoadingMore,
  }) {
    return ProductsByCategoryActive(
      products: products ?? this.products,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      totalCount: totalCount ?? this.totalCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsByCategoryActive &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          hasNextPage == other.hasNextPage &&
          totalCount == other.totalCount &&
          isLoadingMore == other.isLoadingMore &&
          products == other.products;

  @override
  int get hashCode => Object.hash(
    products,
    page,
    hasNextPage,
    totalCount,
    isLoadingMore,
  );
}

class ProductsByCategoryEmpty extends ProductsByCategoryState {
  const ProductsByCategoryEmpty();
}

class ProductsByCategoryError extends ProductsByCategoryState {
  final String message;

  const ProductsByCategoryError({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsByCategoryError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

