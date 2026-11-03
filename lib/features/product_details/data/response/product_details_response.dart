import '../../../../core/network/base_response.dart';

class ProductDetailsResponse implements BasicResponse {
  final String id;
  final String? productCode;
  final String name;
  final String? description;
  final String? nameArabic;
  final String? descriptionArabic;
  final String? coverPictureUrl;
  final List<String> productPictures;
  final List<String> categories;
  final double price;
  final int stock;
  final double? weight;
  final String? color;
  final int discountPercentage;
  final double rating;
  final int reviewsCount;
  final String? sellerId;
  final bool? isSuccess;
  final String? responseMessage;

  const ProductDetailsResponse({
    required this.id,
    this.productCode,
    required this.name,
    this.description,
    this.nameArabic,
    this.descriptionArabic,
    this.coverPictureUrl,
    this.productPictures = const [],
    this.categories = const [],
    required this.price,
    required this.stock,
    this.weight,
    this.color,
    required this.discountPercentage,
    required this.rating,
    required this.reviewsCount,
    this.sellerId,
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to fetch product details');

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    // If wrapped in a 'data' envelope, parse from inner object
    final source = (json.containsKey('data') && json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    return ProductDetailsResponse(
      id: source['id'] as String? ?? '',
      productCode: source['productCode'] as String?,
      name: source['name'] as String? ?? '',
      description: source['description'] as String?,
      nameArabic: (source['nameArabic'] ?? source['arabicName']) as String?,
      descriptionArabic:
          (source['descriptionArabic'] ?? source['arabicDescription']) as String?,
      coverPictureUrl: source['coverPictureUrl'] as String?,
      productPictures: (source['productPictures'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      categories: (source['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      price: (source['price'] as num?)?.toDouble() ?? 0.0,
      stock: (source['stock'] as num?)?.toInt() ?? 0,
      weight: (source['weight'] as num?)?.toDouble(),
      color: source['color'] as String?,
      discountPercentage: (source['discountPercentage'] as num?)?.toInt() ?? 0,
      rating: (source['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (source['reviewsCount'] as num?)?.toInt() ?? 0,
      sellerId: source['sellerId'] as String?,
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    if (productCode != null) 'productCode': productCode,
    'name': name,
    if (description != null) 'description': description,
    if (nameArabic != null) 'nameArabic': nameArabic,
    if (descriptionArabic != null) 'descriptionArabic': descriptionArabic,
    if (coverPictureUrl != null) 'coverPictureUrl': coverPictureUrl,
    'productPictures': productPictures,
    'categories': categories,
    'price': price,
    'stock': stock,
    if (weight != null) 'weight': weight,
    if (color != null) 'color': color,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'reviewsCount': reviewsCount,
    if (sellerId != null) 'sellerId': sellerId,
  };

  @override
  String toString() =>
      'ProductDetailsResponse(id: $id, name: $name, price: $price, stock: $stock)';
}

