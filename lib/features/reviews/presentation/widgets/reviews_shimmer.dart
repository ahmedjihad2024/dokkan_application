import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class ReviewsShimmer extends StatelessWidget {
  const ReviewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: isDark
            ? ColorM.surfaceDarkElevated
            : const Color(0xFFE9EDEE),
        highlightColor: isDark
            ? ColorM.surfaceDarkSubtle
            : const Color(0xFFF7F9FA),
        duration: const Duration(milliseconds: 1400),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top subtitle row: "verified reviews" & "Authentic badge"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bone.text(width: 120.w, fontSize: 13),
                Bone.text(width: 90.w, fontSize: 11),
              ],
            ),
            SizedBox(height: 14.h),

            // Staggered Review Card Skeletons
            for (int i = 0; i < 5; i++) ...[
              _buildReviewCardSkeleton(context, isLongComment: i.isEven),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCardSkeleton(
    BuildContext context, {
    required bool isLongComment,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: context.surfaceSubtleColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Bone.circle(size: 34.r),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(width: 110.w, fontSize: 13),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Bone.text(width: 70.w, fontSize: 11),
                        SizedBox(width: 8.w),
                        Bone.text(width: 50.w, fontSize: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Bone.multiText(
            lines: isLongComment ? 3 : 2,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}

