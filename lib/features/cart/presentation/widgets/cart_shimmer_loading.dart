import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/sizes_manager.dart';

class CartShimmerLoading extends StatelessWidget {
  const CartShimmerLoading({super.key});

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
        padding: EdgeInsets.only(
          left: SizeM.pagePaddingLarge.w,
          right: SizeM.pagePaddingLarge.w,
          bottom: 24.h,
        ),
        child: Column(
          children: [
            // 1. Shimmer Cart Items (3 cards)
            for (int i = 0; i < 3; i++) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildCartItemCardSkeleton(context),
              ),
            ],

            // 2. Shimmer Order Summary Card
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: _buildOrderSummarySkeleton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemCardSkeleton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Bone.square(
            size: 78.w,
            borderRadius: BorderRadius.circular(12.r),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Bone.text(width: 140.w, fontSize: 13),
                6.verticalSpace,
                Bone.text(width: 60.w, fontSize: 11),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Bone.square(
                          size: 28.w,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        8.horizontalSpace,
                        Bone.text(width: 16.w, fontSize: 12),
                        8.horizontalSpace,
                        Bone.square(
                          size: 28.w,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ],
                    ),
                    Bone.circle(size: 28.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummarySkeleton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Bone.text(width: 110.w, fontSize: 14),
          14.verticalSpace,

          // Subtotal row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bone.text(width: 120.w, fontSize: 12),
              Bone.text(width: 55.w, fontSize: 12),
            ],
          ),
          10.verticalSpace,

          // Shipping row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bone.text(width: 140.w, fontSize: 12),
              Bone.text(width: 40.w, fontSize: 12),
            ],
          ),
          12.verticalSpace,

          Divider(height: 1, color: context.borderColor),
          12.verticalSpace,

          // Estimated Total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bone.text(width: 100.w, fontSize: 15),
              Bone.text(width: 70.w, fontSize: 20),
            ],
          ),
          12.verticalSpace,

          // Security note
          Bone.text(width: 220.w, fontSize: 10),
          16.verticalSpace,

          // Proceed to checkout button
          Bone(
            width: double.infinity,
            height: 50.h,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ],
      ),
    );
  }
}

