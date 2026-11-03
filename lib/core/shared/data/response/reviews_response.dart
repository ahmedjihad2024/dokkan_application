import '../../../network/base_response.dart';

class ReviewsResponse implements BasicResponse {
  final String? responseMessage;
  final double averageRating;
  final int reviewsCount;
  final ReviewsPaginationResponse? reviews;
  final bool? isSuccess;

  const ReviewsResponse({
    this.responseMessage,
    required this.averageRating,
    required this.reviewsCount,
    this.reviews,
    this.isSuccess,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to fetch reviews');

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    return ReviewsResponse(
      responseMessage: json['message'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      reviews: json['reviews'] != null && json['reviews'] is Map<String, dynamic>
          ? ReviewsPaginationResponse.fromJson(
              json['reviews'] as Map<String, dynamic>,
            )
          : null,
      isSuccess: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (responseMessage != null) 'message': responseMessage,
    'averageRating': averageRating,
    'reviewsCount': reviewsCount,
    if (reviews != null) 'reviews': reviews!.toJson(),
    if (isSuccess != null) 'success': isSuccess,
  };

  @override
  String toString() =>
      'ReviewsResponse(averageRating: $averageRating, reviewsCount: $reviewsCount, items: ${reviews?.items.length})';
}

class ReviewsPaginationResponse {
  final List<ReviewItemResponse> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const ReviewsPaginationResponse({
    this.items = const [],
    this.page = 1,
    this.pageSize = 10,
    this.totalCount = 0,
    this.hasNextPage = false,
    this.hasPreviousPage = false,
  });

  factory ReviewsPaginationResponse.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return ReviewsPaginationResponse(
      items: rawItems
          .map((e) => ReviewItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
    'page': page,
    'pageSize': pageSize,
    'totalCount': totalCount,
    'hasNextPage': hasNextPage,
    'hasPreviousPage': hasPreviousPage,
  };
}

class ReviewItemResponse {
  final String comment;
  final double rating;
  final String? createdAt;
  final String userName;
  final String? userPicture;

  const ReviewItemResponse({
    required this.comment,
    required this.rating,
    this.createdAt,
    required this.userName,
    this.userPicture,
  });

  factory ReviewItemResponse.fromJson(Map<String, dynamic> json) {
    return ReviewItemResponse(
      comment: json['comment'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] as String?,
      userName: json['userName'] as String? ?? 'Customer',
      userPicture: json['userPicture'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'comment': comment,
    'rating': rating,
    if (createdAt != null) 'createdAt': createdAt,
    'userName': userName,
    if (userPicture != null) 'userPicture': userPicture,
  };
}

