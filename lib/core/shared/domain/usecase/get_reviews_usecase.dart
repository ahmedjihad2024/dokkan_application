import 'package:dartz/dartz.dart';

import '../../../network/error_handler/failure.dart';
import '../../data/request/reviews_request.dart';
import '../model/review_entity.dart';
import '../repository/review_repository.dart';

class GetReviewsUseCase {
  final ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  Future<Either<Failure, List<ReviewEntity>>> call(
    String productId,
    ReviewsRequest request,
  ) {
    return repository.getReviews(productId, request);
  }
}
