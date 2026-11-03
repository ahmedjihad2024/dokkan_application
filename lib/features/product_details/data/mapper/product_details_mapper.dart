import '../../../../core/shared/domain/model/product_entity.dart';
import '../response/product_details_response.dart';

extension ProductDetailsResponseMapper on ProductDetailsResponse {
  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      productCode: productCode,
      name: name,
      description: description,
      arabicName: nameArabic,
      arabicDescription: descriptionArabic,
      coverPictureUrl: coverPictureUrl,
      productPictures: productPictures,
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

