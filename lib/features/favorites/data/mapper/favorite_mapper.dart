import 'package:dokkan/core/shared/domain/model/product_entity.dart';
import '../response/response.dart';

extension FavoriteToProductEntity on Favorite {
  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      productCode: productCode,
      name: name,
      description: description,
      arabicName: arabicName,
      arabicDescription: arabicDescription,
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

extension ProductEntityToFavorite on ProductEntity {
  Favorite toFavorite() {
    return Favorite(
      id: id,
      productCode: productCode,
      name: name,
      description: description,
      arabicName: arabicName,
      arabicDescription: arabicDescription,
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

