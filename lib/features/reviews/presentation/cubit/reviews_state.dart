import '../../../../core/shared/domain/model/review_entity.dart';

abstract class ReviewsState {
  const ReviewsState();
}


class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

class ReviewsSuccess extends ReviewsState {
  final List<ReviewEntity> reviews;
  final double averageRating;
  final int totalReviews;
  final int currentPage;
  final bool hasNextPage;
  final bool isLoadingMore;

  const ReviewsSuccess({
    required this.reviews,
    required this.averageRating,
    required this.totalReviews,
    this.currentPage = 1,
    this.hasNextPage = false,
    this.isLoadingMore = false,
  });

  bool get isEmpty => reviews.isEmpty;
  bool get isNotEmpty => reviews.isNotEmpty;

  ReviewsSuccess copyWith({
    List<ReviewEntity>? reviews,
    double? averageRating,
    int? totalReviews,
    int? currentPage,
    bool? hasNextPage,
    bool? isLoadingMore,
  }) {
    return ReviewsSuccess(
      reviews: reviews ?? this.reviews,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  String toString() =>
      'ReviewsSuccess(count: ${reviews.length}, avg: $averageRating, total: $totalReviews, hasNext: $hasNextPage)';
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError({required this.message});

  @override
  String toString() => 'ReviewsError(message: $message)';
}

