import '../../domain/model/product_entity.dart';
import '../response/product_mutation_response.dart';
import '../response/products_response.dart';

extension ProductItemResponseMapper on ProductItemResponse {
  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      productCode: productCode,
      name: name,
      description: description,
      arabicName: arabicName,
      arabicDescription: arabicDescription,
      coverPictureUrl: coverPictureUrl,
      productPictures: productPictures ?? const [],
      price: price,
      stock: stock,
      weight: weight,
      color: color,
      rating: rating,
      reviewsCount: reviewsCount,
      discountPercentage: discountPercentage,
      sellerId: sellerId,
      categories: categories,
    );
  }
}

extension ProductsResponseMapper on ProductsResponse {
  ProductsPaginationEntity toDomain() {
    return ProductsPaginationEntity(
      items: items.map((i) => i.toDomain()).toList(),
      page: page,
      pageSize: pageSize,
      totalCount: totalCount,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }
}

extension ProductMutationResponseMapper on ProductMutationResponse {
  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      productCode: productCode,
      name: name,
      description: description,
      arabicName: nameArabic,
      arabicDescription: descriptionArabic,
      coverPictureUrl: coverPictureUrl,
      productPictures: pictures,
      price: price,
      stock: stock,
      weight: weight,
      color: color,
      rating: 0.0,
      reviewsCount: 0,
      discountPercentage: discountPercentage,
      sellerId: sellerId,
      categories:
          categories
              .map((c) => c.name.trim())
              .where((name) => name.isNotEmpty)
              .toList(),
    );
  }
}

