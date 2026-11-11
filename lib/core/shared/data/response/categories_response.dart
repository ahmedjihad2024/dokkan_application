import '../../../network/base_response.dart';

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
    final rawList =
        json['categories'] ??
        json['items'] ??
        (json['data'] is List ? json['data'] : null) ??
        const <dynamic>[];
    final list = rawList is List<dynamic> ? rawList : const <dynamic>[];

    return CategoriesResponse(
      categories:
          list
              .whereType<Map<String, dynamic>>()
              .map(CategoryItemResponse.fromJson)
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
    return CategoryItemResponse(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      coverPictureUrl:
          (json['coverPictureUrl'] ?? json['coverImage'] ?? json['image'])
              ?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (description != null) 'description': description,
    if (coverPictureUrl != null) 'coverPictureUrl': coverPictureUrl,
  };
}

