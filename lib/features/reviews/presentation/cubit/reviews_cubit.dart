import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/shared/data/request/reviews_request.dart';
import '../../../../core/shared/domain/model/review_entity.dart';
import '../../../../core/shared/domain/usecase/get_reviews_usecase.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetReviewsUseCase getReviewsUseCase;
  final RefreshController refreshController = RefreshController();

  int _currentPage = 0;
  bool _hasNextPage = false;
  final List<ReviewEntity> _allReviews = [];

  ReviewsCubit({required this.getReviewsUseCase})
      : super(const ReviewsLoading());

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  Future<void> getReviews(String productId, {bool isRefresh = false}) async {
    if (productId.isEmpty) {
      refreshController.refreshFailed();
      emit(const ReviewsError(message: 'Product ID is missing'));
      return;
    }

    if (isRefresh) {
      _currentPage = 1;
      _allReviews.clear();
      emit(const ReviewsLoading());
    } else {
      ++_currentPage;
    }

    final result = await getReviewsUseCase(
      productId,
      ReviewsRequest(page: _currentPage, pageSize: 10),
    );

    result.fold(
      (failure) {
        if (isRefresh) {
          refreshController.refreshFailed();
        } else {
          --_currentPage;
          refreshController.loadFailed();
        }
      },
      (reviews) {
        _hasNextPage = reviews.length >= 10;
        if (isRefresh) {
          _allReviews.clear();
          refreshController.refreshCompleted(resetFooterState: _hasNextPage);
        } else {
          if (_hasNextPage) {
            refreshController.resetNoData();
          } else {
            refreshController.loadNoData();
          }
        }
        _allReviews.addAll(reviews);

        emit(
          ReviewsSuccess(
            reviews: List.unmodifiable(_allReviews),
            averageRating: 0.0,
            totalReviews: _allReviews.length,
            currentPage: _currentPage,
            hasNextPage: _hasNextPage,
          ),
        );
      },
    );
  }
}
