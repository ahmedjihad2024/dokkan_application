import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/widgets/rating/rate_widget.dart';
import '../../data/models/product_review_model.dart';

class ProductReviewsSection extends StatelessWidget {
  final String productName;
  final double rating;
  final int reviewsCount;
  final List<ProductReviewModel> reviews;

  const ProductReviewsSection({
    super.key,
    this.productName = 'Heritage Chronograph Steel Watch',
    this.rating = 4.9,
    this.reviewsCount = 128,
    required this.reviews,
  });

  void _navigateToAllReviews(BuildContext context) {
    context.pushNamed(
      Routes.productReviews,
      arguments: {
        'productName': productName,
        'rating': rating,
        'reviewsCount': reviewsCount,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryText = context.textPrimaryColor;
    final cardBg = context.surfaceSubtleColor;
    final cardBorder = context.borderColor;
    final inactiveStarColor = context.borderColor;
    final commentTextColor = context.textSecondaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row matching Figma 37:541 with Explore All under the rating
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Text(
                'Customer Reviews',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: primaryText,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '★ ${rating.toStringAsFixed(1)} ($reviewsCount reviews)',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorM.ratingGold,
                  ),
                ),
                SizedBox(height: 3.h),
                // Button under the rating as requested
                InkWell(
                  onTap: () => _navigateToAllReviews(context),
                  borderRadius: BorderRadius.circular(4.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore All',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorM.primaryDark,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 9.sp,
                          color: ColorM.primaryDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Review Cards list using RateWidget to control star rating count
        ...reviews.take(2).map((rev) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: cardBorder, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar + Author + Verified + Rating & Date Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar Circle (32x32) matching Figma 37:545
                    Container(
                      width: 32.w,
                      height: 32.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: rev.avatarBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        rev.initials,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorM.white,
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    // Author info & Rating
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                rev.author,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primaryText,
                                ),
                              ),
                              if (rev.isVerified) ...[
                                SizedBox(width: 4.w),
                                Text(
                                  '✓ Verified Buyer',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ColorM.success,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              // RateWidget controlling the rating count
                              RateWidget(
                                initialRate: rev.rating,
                                readonly: true,
                                size: 12.w,
                                spacing: 2.w,
                                activeColor: ColorM.ratingGold,
                                inactiveColor: inactiveStarColor,
                                allowHalfRating: true,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '• ${rev.dateText}',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: context.textMutedColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Comment Quote text matching Figma 37:549 / 37:609
                Text(
                  rev.comment,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: commentTextColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        }),

        SizedBox(height: 4.h),

        // Full width outline button below cards to explore all reviews
        SizedBox(
          width: double.infinity,
          height: 42.h,
          child: OutlinedButton(
            onPressed: () => _navigateToAllReviews(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: cardBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              backgroundColor: cardBg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Explore All $reviewsCount Reviews',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: context.isDark ? ColorM.primary : ColorM.primaryDark,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 15.sp,
                  color: context.isDark ? ColorM.primary : ColorM.primaryDark,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
