import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import 'cubit/reviews_cubit.dart';
import 'cubit/reviews_state.dart';
import 'widgets/reviews_app_bar.dart';
import 'widgets/reviews_list_view.dart';
import 'widgets/reviews_shimmer.dart';

class ReviewsScreen extends StatelessWidget {
  final String productId;
  final String productName;
  final double averageRating;
  final int totalReviews;

  const ReviewsScreen({
    super.key,
    required this.productId,
    this.productName = 'Product Reviews',
    this.averageRating = 5.0,
    this.totalReviews = 0,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewsCubit>();

    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listener: (context, state) {
        if (state is ReviewsError) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final avgRating = state is ReviewsSuccess
            ? (state.averageRating > 0
                ? state.averageRating
                : averageRating)
            : averageRating;
        final totalCount = state is ReviewsSuccess
            ? (state.totalReviews > 0
                ? state.totalReviews
                : totalReviews)
            : totalReviews;

        return Scaffold(
          backgroundColor: context.scaffoldBackgroundColor,
          appBar: ReviewsAppBar(
            productName: productName,
            averageRating: avgRating,
            totalReviews: totalCount,
          ),
          body: _buildBody(context, cubit, state),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ReviewsCubit cubit,
    ReviewsState state,
  ) {
    if (state is ReviewsLoading) {
      return const ReviewsShimmer();
    }

    if (state is ReviewsError) {
      return Center(
        child: AppErrorWidget(
          message: state.message,
          onRetry: () {
            cubit.getReviews(productId, isRefresh: true);
          },
        ),
      );
    }

    if (state is ReviewsSuccess) {
      if (state.isEmpty) {
        return Center(
          child: Text(
            'No reviews yet for this product',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.textSecondaryColor,
            ),
          ).animate().fadeIn(duration: 400.ms),
        );
      }

      return CustomizedSmartRefresh(
        controller: cubit.refreshController,
        enableRefresh: true,
        enableLoading: true,
        onRefresh: () => cubit.getReviews(productId, isRefresh: true),
        onLoading: () => cubit.getReviews(productId),
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
                      '${state.reviews.length} verified reviews',
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
                ),
              ),
            ),

            // Reviews list
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: ReviewsListView(reviews: state.reviews),
            ),

            // Bottom breathing space
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
          .slideY(begin: 0.04, end: 0, curve: Curves.easeOutCubic);
    }

    return const SizedBox.shrink();
  }
}
