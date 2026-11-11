import '../../../network/base_response.dart';

class ProductCategoryRefResponse {
  final String id;
  final String name;

  const ProductCategoryRefResponse({required this.id, required this.name});

  factory ProductCategoryRefResponse.fromDynamic(dynamic item) {
    if (item is Map<String, dynamic>) {
      return ProductCategoryRefResponse(
        id: item['id']?.toString() ?? '',
        name: item['name']?.toString() ?? '',
      );
    }
    return ProductCategoryRefResponse(id: '', name: item?.toString() ?? '');
  }
}

class ProductMutationResponse implements BasicResponse {
  final String id;
  final String? sellerId;
  final String? productCode;
  final String name;
  final String? description;
  final String? nameArabic;
  final String? descriptionArabic;
  final String? coverPictureUrl;
  final double price;
  final int stock;
  final double? weight;
  final String? color;
  final int discountPercentage;
  final List<ProductCategoryRefResponse> categories;
  final List<String> pictures;
  final bool? isSuccess;
  final String? responseMessage;

  const ProductMutationResponse({
    required this.id,
    this.sellerId,
    this.productCode,
    required this.name,
    this.description,
    this.nameArabic,
    this.descriptionArabic,
    this.coverPictureUrl,
    required this.price,
    required this.stock,
    this.weight,
    this.color,
    required this.discountPercentage,
    this.categories = const [],
    this.pictures = const [],
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success => isSuccess ?? id.isNotEmpty;

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to save product');

  factory ProductMutationResponse.fromJson(Map<String, dynamic> json) {
    final source =
        json['data'] is Map<String, dynamic>
            ? json['data'] as Map<String, dynamic>
            : json;

    final rawCategories = source['categories'] as List<dynamic>? ?? const [];
    final rawPictures =
        (source['pictures'] ?? source['productPictures']) as List<dynamic>? ??
        const [];

    return ProductMutationResponse(
      id: source['id']?.toString() ?? '',
      sellerId: source['sellerId']?.toString(),
      productCode: source['productCode']?.toString(),
      name: source['name']?.toString() ?? '',
      description: source['description']?.toString(),
      nameArabic: (source['nameArabic'] ?? source['arabicName'])?.toString(),
      descriptionArabic:
          (source['descriptionArabic'] ?? source['arabicDescription'])
              ?.toString(),
      coverPictureUrl: source['coverPictureUrl']?.toString(),
      price: (source['price'] as num?)?.toDouble() ?? 0.0,
      stock: (source['stock'] as num?)?.toInt() ?? 0,
      weight: (source['weight'] as num?)?.toDouble(),
      color: source['color']?.toString(),
      discountPercentage:
          (source['discountPercentage'] as num?)?.toInt() ?? 0,
      categories:
          rawCategories
              .map(ProductCategoryRefResponse.fromDynamic)
              .toList(),
      pictures:
          rawPictures
              .map(
                (e) =>
                    e is Map<String, dynamic>
                        ? (e['url'] ?? e['pictureUrl'] ?? e['imageUrl'] ?? '')
                            .toString()
                        : e.toString(),
              )
              .where((url) => url.trim().isNotEmpty)
              .toList(),
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }
}

