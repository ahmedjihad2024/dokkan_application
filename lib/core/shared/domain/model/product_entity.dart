class ProductEntity {
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

  const ProductEntity({
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
    this.categories = const [],

  });

  /// Computes final price after applying discount (if any)
  double get finalPrice => discountPercentage > 0
      ? price * (1.0 - (discountPercentage / 100.0))
      : price;

  /// Returns whether this product currently has an active discount
  bool get hasDiscount => discountPercentage > 0;

  /// Returns whether this product is available in stock
  bool get isInStock => stock > 0;

  ProductEntity copyWith({
    String? id,
    String? productCode,
    String? name,
    String? description,
    String? arabicName,
    String? arabicDescription,
    String? coverPictureUrl,
    List<String>? productPictures,
    double? price,
    int? stock,
    double? weight,
    String? color,
    double? rating,
    int? reviewsCount,
    int? discountPercentage,
    String? sellerId,
    List<String>? categories,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      productCode: productCode ?? this.productCode,
      name: name ?? this.name,
      description: description ?? this.description,
      arabicName: arabicName ?? this.arabicName,
      arabicDescription: arabicDescription ?? this.arabicDescription,
      coverPictureUrl: coverPictureUrl ?? this.coverPictureUrl,
      productPictures: productPictures ?? this.productPictures,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      weight: weight ?? this.weight,
      color: color ?? this.color,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      sellerId: sellerId ?? this.sellerId,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() =>
      'ProductEntity(id: $id, name: $name, price: $price, finalPrice: $finalPrice)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ProductsPaginationEntity {
  final List<ProductEntity> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const ProductsPaginationEntity({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  String toString() =>
      'ProductsPaginationEntity(page: $page, totalCount: $totalCount, itemsCount: ${items.length})';
}

