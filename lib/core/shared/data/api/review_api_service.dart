import 'package:dio/dio.dart';

import '../request/reviews_request.dart';
import '../response/reviews_response.dart';

abstract class ReviewApiService {
  Future<ReviewsResponse> getReviews(String productId, ReviewsRequest request);
}

class ReviewApiServiceImpl implements ReviewApiService {
  final Dio _dio;

  ReviewApiServiceImpl(this._dio);

  @override
  Future<ReviewsResponse> getReviews(
    String productId,
    ReviewsRequest request,
  ) async {
    final response = await _dio.get(
      '/api/reviews/$productId',
      data: request.toJson(),
    );

    return ReviewsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

