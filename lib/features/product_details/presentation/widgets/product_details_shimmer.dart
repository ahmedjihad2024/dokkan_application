import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

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
      child: Column(
        children: [
          // Scrollable Body Shimmer
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Hero Image Container Shimmer (342x172, radius 20)
                  Bone(
                    width: double.infinity,
                    height: 172.h,
                    borderRadius: BorderRadius.circular(20.r),
                  ),

                  SizedBox(height: 12.h),

                  // 2. Thumbnail Row Shimmer
                  Row(
                    children: List.generate(
                      4,
                      (i) => Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Bone(
                          width: 52.w,
                          height: 52.w,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // 3. Product Title & Code Shimmer
                  Bone.text(
                    width: 220.w,
                    fontSize: 18,
                  ),
                  SizedBox(height: 6.h),
                  Bone.text(
                    width: 140.w,
                    fontSize: 11,
                  ),

                  SizedBox(height: 14.h),

                  // 4. Rating & Reviews Count Row Shimmer
                  Row(
                    children: [
                      Bone.text(width: 60.w, fontSize: 13),
                      SizedBox(width: 8.w),
                      Bone.text(width: 80.w, fontSize: 11),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // 5. Price & Discount Tag Row Shimmer
                  Row(
                    children: [
                      Bone.text(width: 90.w, fontSize: 20),
                      SizedBox(width: 10.w),
                      Bone.text(width: 60.w, fontSize: 13),
                      SizedBox(width: 8.w),
                      Bone(
                        width: 45.w,
                        height: 22.h,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // 6. Chips Row (Material & Weight) Shimmer
                  Row(
                    children: [
                      Bone(
                        width: 80.w,
                        height: 32.h,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      SizedBox(width: 8.w),
                      Bone(
                        width: 95.w,
                        height: 32.h,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // 7. Description Section Header & Paragraph Shimmer
                  const Bone.text(words: 1, fontSize: 15),
                  SizedBox(height: 8.h),
                  const Bone.multiText(
                    lines: 3,
                    fontSize: 12,
                  ),

                  SizedBox(height: 20.h),

                  // 8. Reviews Section Shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Bone.text(words: 2, fontSize: 16),
                      Bone.text(width: 60.w, fontSize: 13),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Bone(
                    width: double.infinity,
                    height: 90.h,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Bar Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              children: [
                Bone(
                  width: 110.w,
                  height: 48.h,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Bone(
                    height: 48.h,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
