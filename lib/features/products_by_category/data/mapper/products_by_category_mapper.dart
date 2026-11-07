import '../../../../core/shared/data/mapper/product_mapper.dart';
import '../../domain/model/products_by_category_entity.dart';
import '../response/products_by_category_response.dart';

extension ProductsByCategoryResponseMapper on ProductsByCategoryResponse {
  ProductsByCategoryPageEntity toDomain() {
    return ProductsByCategoryPageEntity(
      items: items.map((i) => i.toDomain()).toList(),
      page: page,
      pageSize: pageSize,
      totalCount: totalCount,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }
}

