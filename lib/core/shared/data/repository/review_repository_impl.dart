import 'package:dartz/dartz.dart';

import '../../../network/error_handler/error_handler.dart';
import '../../../network/error_handler/failure.dart';
import '../../domain/model/review_entity.dart';
import '../../domain/repository/review_repository.dart';
import '../data_source/review_remote_data_source.dart';
import '../mapper/review_mapper.dart';
import '../request/reviews_request.dart';
import '../response/reviews_response.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource _remoteDataSource;

  ReviewRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviews(
    String productId,
    ReviewsRequest request,
  ) {
    return fastHandler<ReviewsResponse, List<ReviewEntity>>(
      request: () => _remoteDataSource.getReviews(productId, request),
      mapper: (response) => response.toDomain(),
    );
  }
}
