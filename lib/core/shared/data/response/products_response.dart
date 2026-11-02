import '../../../network/base_response.dart';

class ProductsResponse implements BasicResponse {
  final List<ProductItemResponse> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final bool? isSuccess;
  final String? responseMessage;

  const ProductsResponse({
    this.items = const [],
    this.page = 1,
    this.pageSize = 10,
    this.totalCount = 0,
    this.hasNextPage = false,
    this.hasPreviousPage = false,
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to fetch products');

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['items'] as List<dynamic>? ?? [];
    return ProductsResponse(
      items: rawList
          .map((i) => ProductItemResponse.fromJson(i as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      totalCount: json['totalCount'] as int? ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'items': items.map((i) => i.toJson()).toList(),
    'page': page,
    'pageSize': pageSize,
    'totalCount': totalCount,
    'hasNextPage': hasNextPage,
    'hasPreviousPage': hasPreviousPage,
    if (isSuccess != null) 'success': isSuccess,
    if (responseMessage != null) 'message': responseMessage,
  };

  @override
  String toString() =>
      'ProductsResponse(itemsCount: ${items.length}, page: $page, totalCount: $totalCount)';
}

class ProductItemResponse {
  final String id;
  final String? productCode;
  final String name;
  final String? description;
  final String? arabicName;
  final String? arabicDescription;
  final String? coverPictureUrl;
  final List<String>? productPictures;
  final double price;
  final int stock;
  final double? weight;
  final String? color;
  final double rating;
  final int reviewsCount;
  final int discountPercentage;
  final String? sellerId;
  final List<String> categories;

  const ProductItemResponse({
    required this.id,
    this.productCode,
    required this.name,
    this.description,
    this.arabicName,
    this.arabicDescription,
    this.coverPictureUrl,
    this.productPictures,
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

  factory ProductItemResponse.fromJson(Map<String, dynamic> json) {
    return ProductItemResponse(
      id: json['id'] as String? ?? '',
      productCode: json['productCode'] as String?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      arabicName: json['arabicName'] as String?,
      arabicDescription: json['arabicDescription'] as String?,
      coverPictureUrl: json['coverPictureUrl'] as String?,
      productPictures: (json['productPictures'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      weight: (json['weight'] as num?)?.toDouble(),
      color: json['color'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toInt() ?? 0,
      sellerId: json['sellerId'] as String?,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    if (productCode != null) 'productCode': productCode,
    'name': name,
    if (description != null) 'description': description,
    if (arabicName != null) 'arabicName': arabicName,
    if (arabicDescription != null) 'arabicDescription': arabicDescription,
    if (coverPictureUrl != null) 'coverPictureUrl': coverPictureUrl,
    if (productPictures != null) 'productPictures': productPictures,
    'price': price,
    'stock': stock,
    if (weight != null) 'weight': weight,
    if (color != null) 'color': color,
    'rating': rating,
    'reviewsCount': reviewsCount,
    'discountPercentage': discountPercentage,
    if (sellerId != null) 'sellerId': sellerId,
    'categories': categories,
  };

  @override
  String toString() =>
      'ProductItemResponse(id: $id, name: $name, price: $price, stock: $stock)';
}

