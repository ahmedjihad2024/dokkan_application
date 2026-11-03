import '../api/review_api_service.dart';
import '../request/reviews_request.dart';
import '../response/reviews_response.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewsResponse> getReviews(String productId, ReviewsRequest request);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final ReviewApiService _apiService;

  ReviewRemoteDataSourceImpl(this._apiService);

  @override
  Future<ReviewsResponse> getReviews(
    String productId,
    ReviewsRequest request,
  ) =>
      _apiService.getReviews(productId, request);
}

