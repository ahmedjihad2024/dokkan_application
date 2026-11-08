import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/sizes_manager.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({super.key});

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
          horizontal: SizeM.pagePadding.w,
          vertical: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header count bone
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Bone.text(
                width: 100.w,
                fontSize: 13,
              ),
            ),

            // Products Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: SizeM.elementSpacing.w,
                mainAxisSpacing: SizeM.elementSpacing.h,
                childAspectRatio: 165 / 290,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: context.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Bone(
                        width: double.infinity,
                        height: 145.h,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Bone.text(words: 2, fontSize: 13),
                            SizedBox(height: 6.h),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Bone.text(width: 55.w, fontSize: 14),
                                Bone.text(width: 35.w, fontSize: 11),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Bone(
                              width: double.infinity,
                              height: 32.h,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ],
                        ),
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

