import '../../../../core/shared/domain/model/product_entity.dart';

class ProductsByCategoryPageEntity {
  final List<ProductEntity> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const ProductsByCategoryPageEntity({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });
}

