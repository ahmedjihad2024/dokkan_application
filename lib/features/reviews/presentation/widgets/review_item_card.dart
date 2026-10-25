import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/rating/rate_widget.dart';
import '../../../product_details/data/models/product_review_model.dart';

class ReviewItemCard extends StatelessWidget {
  final ProductReviewModel review;

  const ReviewItemCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final primaryText = context.textPrimaryColor;
    final cardBg = context.surfaceSubtleColor;
    final cardBorder = context.borderColor;
    final inactiveStarColor = context.borderColor;
    final commentTextColor = context.textSecondaryColor;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
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
              // Avatar
              Container(
                width: 34.w,
                height: 34.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: review.avatarBgColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  review.initials,
                  style: TextStyle(
                    fontSize: 12.sp,
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
                          review.author,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: primaryText,
                          ),
                        ),
                        if (review.isVerified) ...[
                          SizedBox(width: 6.w),
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
                        RateWidget(
                          initialRate: review.rating,
                          readonly: true,
                          size: 12.w,
                          spacing: 2.w,
                          activeColor: ColorM.ratingGold,
                          inactiveColor: inactiveStarColor,
                          allowHalfRating: true,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '• ${review.dateText}',
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

          SizedBox(height: 10.h),

          // Comment Quote text
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: commentTextColor,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
