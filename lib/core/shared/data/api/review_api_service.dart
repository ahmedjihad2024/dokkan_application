import 'package:dokkan/core/network/dio_factory.dart';

import '../request/reviews_request.dart';
import '../response/reviews_response.dart';

abstract class ReviewApiService {
  Future<ReviewsResponse> getReviews(String productId, ReviewsRequest request);
}

class ReviewApiServiceImpl implements ReviewApiService {
  final DioFactory _dio;

  ReviewApiServiceImpl(this._dio);

  @override
  Future<ReviewsResponse> getReviews(
    String productId,
    ReviewsRequest request,
  ) async {
    final response = await _dio.request(
      '/api/reviews/$productId',
      method: RequestMethod.GET,
      body: request.toJson(),
    );

    return ReviewsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
