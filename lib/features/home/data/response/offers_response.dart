import '../../../../core/network/base_response.dart';

class OffersResponse implements BasicResponse {
  final OffersDataResponse? offers;
  final bool? isSuccess;
  final String? responseMessage;

  const OffersResponse({
    this.offers,
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success => isSuccess ?? (offers != null);

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to fetch offers');

  factory OffersResponse.fromJson(Map<String, dynamic> json) {
    return OffersResponse(
      offers: json['offers'] != null && json['offers'] is Map<String, dynamic>
          ? OffersDataResponse.fromJson(json['offers'] as Map<String, dynamic>)
          : null,
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (offers != null) 'offers': offers!.toJson(),
    if (isSuccess != null) 'success': isSuccess,
    if (responseMessage != null) 'message': responseMessage,
  };

  @override
  String toString() =>
      'OffersResponse(success: $success, itemsCount: ${offers?.items.length})';
}

class OffersDataResponse {
  final List<OfferItemResponse> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const OffersDataResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory OffersDataResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['items'] as List<dynamic>? ?? [];
    return OffersDataResponse(
      items: rawList
          .map((item) =>
              OfferItemResponse.fromJson(item as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      totalCount: json['totalCount'] as int? ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'items': items.map((i) => i.toJson()).toList(),
    'page': page,
    'pageSize': pageSize,
    'totalCount': totalCount,
    'hasNextPage': hasNextPage,
    'hasPreviousPage': hasPreviousPage,
  };
}

class OfferItemResponse {
  final String id;
  final String name;
  final String? description;
  final String coverUrl;
  final String? createdAt;

  const OfferItemResponse({
    required this.id,
    required this.name,
    this.description,
    required this.coverUrl,
    this.createdAt,
  });

  factory OfferItemResponse.fromJson(Map<String, dynamic> json) {
    return OfferItemResponse(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      coverUrl: json['coverUrl'] as String? ?? '',
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (description != null) 'description': description,
    'coverUrl': coverUrl,
    if (createdAt != null) 'createdAt': createdAt,
  };

  @override
  String toString() =>
      'OfferItemResponse(id: $id, name: $name, coverUrl: $coverUrl)';
}

