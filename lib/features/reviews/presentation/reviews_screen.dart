import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
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
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 800));
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
      body: ReqStateWidget(
        state: _state,
        errorMessage: '',
        onRetry: () {},
        onLoading: (_) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
          ),
        ),
        onFailure: (context, error) => AppErrorWidget(
          message: error ?? '',
          onRetry: () {},
        ),
        onEmpty: (context) => Center(
          child: Text(
            'No reviews yet for this product',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.textSecondaryColor,
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms),
        ),
        onSuccess: (context) => CustomizedSmartRefresh(
          controller: _refreshController,
          enableRefresh: true,
          enableLoading: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Rating subtitle & authenticity badge
              SliverPadding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 14.h,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_reviews.length} verified reviews',
                        style: TextStyle(
                          color: context.textSecondaryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            size: 14.sp,
                            color: ColorM.success,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '100% Authentic',
                            style: TextStyle(
                              color: ColorM.success,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        curve: Curves.easeOutCubic,
                      ),
                ),
              ),

              // Reviews list with staggered animated cards
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: ReviewsListView(reviews: _reviews),
              ),

              // Bottom breathing space
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
