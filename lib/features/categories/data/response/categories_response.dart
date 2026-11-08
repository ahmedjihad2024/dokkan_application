import '../../../../core/network/base_response.dart';

class CategoriesResponse implements BasicResponse {
  final List<CategoryItemResponse> categories;
  final bool? isSuccess;
  final String? responseMessage;

  const CategoriesResponse({
    this.categories = const [],
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to load categories');

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    final dynamic rawList =
        json['categories'] ?? json['data'] ?? json['items'] ?? json['result'];
    final list = rawList is List<dynamic> ? rawList : <dynamic>[];
    return CategoriesResponse(
      categories: list
          .whereType<Map<String, dynamic>>()
          .map((item) => CategoryItemResponse.fromJson(item))
          .toList(),
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'categories': categories.map((c) => c.toJson()).toList(),
    if (isSuccess != null) 'success': isSuccess,
    if (responseMessage != null) 'message': responseMessage,
  };

  @override
  String toString() =>
      'CategoriesResponse(success: $success, categoriesCount: ${categories.length})';
}

class CategoryItemResponse {
  final String id;
  final String name;
  final String? description;
  final String? coverPictureUrl;

  const CategoryItemResponse({
    required this.id,
    required this.name,
    this.description,
    this.coverPictureUrl,
  });

  factory CategoryItemResponse.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'] ??
        json['_id'] ??
        json['categoryId'] ??
        json['category_id'] ??
        json['name'];
    final rawName = json['name'] ??
        json['title'] ??
        json['categoryName'] ??
        json['category'];

    return CategoryItemResponse(
      id: rawId?.toString() ?? '',
      name: rawName?.toString() ?? '',
      description: (json['description'] ?? json['desc'])?.toString(),
      coverPictureUrl: json['coverPictureUrl']?.toString() ??
          json['coverImage']?.toString() ??
          json['image']?.toString() ??
          json['imageUrl']?.toString() ??
          json['pictureUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (description != null) 'description': description,
    if (coverPictureUrl != null) 'coverPictureUrl': coverPictureUrl,
  };
}

