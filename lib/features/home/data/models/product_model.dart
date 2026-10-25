class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final double currentPrice;
  final double? originalPrice;
  final double rating;
  final int reviewsCount;
  final String emoji;
  final String? imageUrl;
  final String? discountTag;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.currentPrice,
    this.originalPrice,
    required this.rating,
    required this.reviewsCount,
    this.emoji = '👜',
    this.imageUrl,
    this.discountTag,
    this.isFavorite = false,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? categoryId,
    double? currentPrice,
    double? originalPrice,
    double? rating,
    int? reviewsCount,
    String? emoji,
    String? imageUrl,
    String? discountTag,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      currentPrice: currentPrice ?? this.currentPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      emoji: emoji ?? this.emoji,
      imageUrl: imageUrl ?? this.imageUrl,
      discountTag: discountTag ?? this.discountTag,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
