


class Favorite {
  final String id;
  final String? productCode;
  final String name;
  final String? description;
  final String? arabicName;
  final String? arabicDescription;
  final String? coverPictureUrl;
  final List<String> productPictures;
  final double price;
  final int stock;
  final double? weight;
  final String? color;
  final double rating;
  final int reviewsCount;
  final int discountPercentage;
  final String? sellerId;
  final List<String> categories;

  const Favorite({
    required this.id,
    this.productCode,
    required this.name,
    this.description,
    this.arabicName,
    this.arabicDescription,
    this.coverPictureUrl,
    this.productPictures = const [],
    required this.price,
    required this.stock,
    this.weight,
    this.color,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
    this.sellerId,
    this.categories = const []
  });
}