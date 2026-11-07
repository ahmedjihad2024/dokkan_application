import '../../../../core/network/base_response.dart';
import '../../../../core/shared/data/response/products_response.dart';

class ProductsByCategoryResponse implements BasicResponse {
  final List<ProductItemResponse> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final bool? isSuccess;
  final String? responseMessage;

  const ProductsByCategoryResponse({
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

  factory ProductsByCategoryResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['items'] as List<dynamic>? ?? [];
    return ProductsByCategoryResponse(
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
}

