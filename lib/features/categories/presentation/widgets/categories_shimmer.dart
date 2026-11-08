import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/sizes_manager.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

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
        padding: EdgeInsets.symmetric(
          horizontal: SizeM.pagePaddingLarge.w,
          vertical: 8.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header count bone
            Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: Bone.text(
                width: 100.w,
                fontSize: 13,
              ),
            ),

            // 2-column Grid matching CategoriesGrid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: SizeM.elementSpacing.h,
                crossAxisSpacing: SizeM.elementSpacing.w,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
                    border: Border.all(color: context.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: context.borderColor.withValues(alpha: 0.05),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Bone.square(
                        size: 72.r,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      Gap(14.h),
                      Bone.text(
                        width: (75 + (index % 3) * 15).w,
                        fontSize: 15,
                      ),
                      Gap(6.h),
                      Bone.text(
                        width: (50 + (index % 2) * 20).w,
                        fontSize: 12,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
