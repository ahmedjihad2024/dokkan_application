import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/shared/domain/model/review_entity.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';
import '../../../../core/widgets/rating/rate_widget.dart';

class ProductReviewsSection extends StatelessWidget {
  final String? productId;
  final String productName;
  final double rating;
  final int reviewsCount;
  final List<ReviewEntity> reviews;
  final VoidCallback? onExploreAll;

  const ProductReviewsSection({
    super.key,
    this.productId,
    this.productName = 'Product',
    this.rating = 5.0,
    this.reviewsCount = 0,
    required this.reviews,
    this.onExploreAll,
  });

  void _navigateToAllReviews(BuildContext context) {
    if (onExploreAll != null) {
      onExploreAll!();
      return;
    }
    context.pushNamed(
      Routes.productReviews,
      arguments: {
        'productId': productId ?? '',
        'productName': productName,
        'rating': rating,
        'reviewsCount': reviewsCount,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const SizedBox.shrink();

    final primaryText = context.textPrimaryColor;
    final cardBg = context.surfaceSubtleColor;
    final cardBorder = context.borderColor;
    final inactiveStarColor = context.borderColor;
    final commentTextColor = context.textSecondaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row with Explore All under the rating
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

        // Review Cards (at most 2 reviews displayed)
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
                // Avatar + Author + Rating & Date Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar Circle (32x32)
                    Container(
                      width: 32.w,
                      height: 32.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: rev.avatarBgColor,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: rev.userPicture != null &&
                              rev.userPicture!.isNotEmpty
                          ? CustomCachedImage(
                              imageUrl: rev.userPicture!,
                              width: 32.w,
                              height: 32.w,
                              fit: BoxFit.cover,
                              errorWidget: Center(
                                child: Text(
                                  rev.initials,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorM.white,
                                  ),
                                ),
                              ),
                            )
                          : Text(
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
                          Text(
                            rev.userName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: primaryText,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              RateWidget(
                                initialRate: rev.rating,
                                readonly: true,
                                size: 12.w,
                                spacing: 2.w,
                                activeColor: ColorM.ratingGold,
                                inactiveColor: inactiveStarColor,
                                allowHalfRating: true,
                              ),
                              if (rev.dateText.isNotEmpty) ...[
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Review Comment Body
                Text(
                  rev.comment,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: commentTextColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
