class UpdateProductRequest {
  final String id;
  final String? name;
  final String? nameArabic;
  final String? description;
  final String? descriptionArabic;
  final String? coverPictureUrl;
  final double? price;
  final int? stock;
  final double? weight;
  final String? color;
  final int? discountPercentage;
  final List<String>? categoryIds;
  final List<String>? productPictures;

  const UpdateProductRequest({
    required this.id,
    this.name,
    this.nameArabic,
    this.description,
    this.descriptionArabic,
    this.coverPictureUrl,
    this.price,
    this.stock,
    this.weight,
    this.color,
    this.discountPercentage,
    this.categoryIds,
    this.productPictures,
  });

  bool get hasChanges =>
      name != null ||
      nameArabic != null ||
      description != null ||
      descriptionArabic != null ||
      coverPictureUrl != null ||
      price != null ||
      stock != null ||
      weight != null ||
      color != null ||
      discountPercentage != null ||
      categoryIds != null ||
      productPictures != null;

  Map<String, dynamic> toJson() => {
    'name': name,
    'nameArabic': nameArabic,
    'description': description,
    'descriptionArabic': descriptionArabic,
    'coverPictureUrl': coverPictureUrl,
    'price': price,
    'stock': stock,
    'weight': weight,
    'color': color,
    'discountPercentage': discountPercentage,
    'categoryIds': categoryIds,
    'productPictures': productPictures,
  };
}

