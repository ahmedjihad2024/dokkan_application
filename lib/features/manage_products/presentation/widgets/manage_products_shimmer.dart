import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class ManageProductsShimmer extends StatelessWidget {
  const ManageProductsShimmer({super.key});

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
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        itemCount: 6,
        itemBuilder: (context, index) => const _ManageProductSkeletonCard(),
      ),
    );
  }
}

class _ManageProductSkeletonCard extends StatelessWidget {
  const _ManageProductSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        children: [
          Bone(
            width: 64.w,
            height: 64.w,
            borderRadius: BorderRadius.circular(10.r),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(width: 140.w, fontSize: 12),
                SizedBox(height: 6.h),
                Bone.text(width: 95.w, fontSize: 10),
                SizedBox(height: 8.h),
                Bone.text(width: 110.w, fontSize: 12),
              ],
            ),
          ),
          8.horizontalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Bone(
                width: 28.w,
                height: 28.w,
                borderRadius: BorderRadius.circular(8.r),
              ),
              SizedBox(width: 8.w),
              Bone(
                width: 28.w,
                height: 28.w,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

