import 'package:flutter/material.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import '../../product_details/data/models/product_review_model.dart';
import 'widgets/reviews_app_bar.dart';
import 'widgets/reviews_list_view.dart';

class ReviewsScreen extends StatefulWidget {
  final String productName;
  final double averageRating;
  final int totalReviews;
  final List<ProductReviewModel>? initialReviews;

  const ReviewsScreen({
    super.key,
    this.productName = 'Heritage Chronograph Steel Watch',
    this.averageRating = 4.9,
    this.totalReviews = 128,
    this.initialReviews,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final RefreshController _refreshController = RefreshController();
  late List<ProductReviewModel> _reviews;
  ReqState _state = ReqState.success;

  @override
  void initState() {
    super.initState();
    _reviews = List.from(
      widget.initialReviews ?? ProductReviewModel.defaultReviews(),
    );
    if (_reviews.isEmpty) {
      _state = ReqState.empty;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: ReviewsAppBar(
        productName: widget.productName,
        averageRating: widget.averageRating,
        totalReviews: widget.totalReviews,
      ),
      body: CustomizedSmartRefresh(
        controller: _refreshController,
        enableLoading: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ReqStateWidget(
          state: _state,
          onSuccess: (context) => ReviewsListView(reviews: _reviews),
        ),
      ),
    );
  }
}
