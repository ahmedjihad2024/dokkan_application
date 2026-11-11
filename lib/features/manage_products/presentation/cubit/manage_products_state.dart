import '../../../../core/shared/domain/model/product_entity.dart';

abstract class ManageProductsState {
  const ManageProductsState();
}

class ManageProductsInitial extends ManageProductsState {
  const ManageProductsInitial();
}

class ManageProductsLoading extends ManageProductsState {
  const ManageProductsLoading();
}

class ManageProductsActive extends ManageProductsState {
  final List<ProductEntity> products;
  final int page;
  final int totalCount;
  final bool hasNextPage;
  final bool isLoadingMore;
  final String? deletingProductId;

  const ManageProductsActive({
    required this.products,
    required this.page,
    required this.totalCount,
    required this.hasNextPage,
    this.isLoadingMore = false,
    this.deletingProductId,
  });

  bool isDeleting(String id) => deletingProductId == id;

  ManageProductsActive copyWith({
    List<ProductEntity>? products,
    int? page,
    int? totalCount,
    bool? hasNextPage,
    bool? isLoadingMore,
    String? deletingProductId,
    bool clearDeletingProductId = false,
  }) {
    return ManageProductsActive(
      products: products ?? this.products,
      page: page ?? this.page,
      totalCount: totalCount ?? this.totalCount,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      deletingProductId: clearDeletingProductId
          ? null
          : (deletingProductId ?? this.deletingProductId),
    );
  }
}

class ManageProductsEmpty extends ManageProductsState {
  const ManageProductsEmpty();
}

class ManageProductsError extends ManageProductsState {
  final String message;

  const ManageProductsError({required this.message});
}

abstract class ManageProductsActionState extends ManageProductsState {
  final String message;

  const ManageProductsActionState(this.message);
}

class ManageProductsActionSuccess extends ManageProductsActionState {
  const ManageProductsActionSuccess(super.message);
}

class ManageProductsActionError extends ManageProductsActionState {
  const ManageProductsActionError(super.message);
}
