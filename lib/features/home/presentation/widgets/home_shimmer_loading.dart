import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Shimmer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Bone.text(words: 2, fontSize: 11),
                    SizedBox(height: 8.h),
                    Bone.text(
                      width: 200.w,
                      fontSize: 22,
                    ),
                    SizedBox(height: 8.h),
                    Bone.text(
                      width: 250.w,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // 2. Promo Banner Shimmer (140.h matching HomePromoBanner)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 140.h,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(18.w, 16.h, 16.w, 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: isDark
                        ? ColorM.surfaceDarkElevated
                        : const Color(0xFFE9EDEE),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Bone(
                                  width: 90.w,
                                  height: 18.h,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                SizedBox(height: 8.h),
                                Bone.text(width: 140.w, fontSize: 16),
                                SizedBox(height: 6.h),
                                Bone.text(width: 180.w, fontSize: 12),
                              ],
                            ),
                            Row(
                              children: List.generate(
                                3,
                                (i) => Padding(
                                  padding: EdgeInsets.only(right: 6.w),
                                  child: Bone(
                                    width: i == 0 ? 18.w : 6.w,
                                    height: 6.h,
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Bone.square(
                        size: 76.w,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // 3. Collections Section Shimmer (matching CollectionsSection)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Bone.text(words: 1, fontSize: 16),
                    Bone.text(width: 50.w, fontSize: 12),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 36.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (_, _) => SizedBox(width: 8.w),
                  itemBuilder: (_, i) => Bone(
                    width: (70 + (i % 3) * 18).w,
                    height: 36.h,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // 4. Curated Arrivals Section Shimmer (matching ProductCard 165.w, 265.h)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Bone.text(words: 2, fontSize: 16),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                height: 265.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (_, _) => SizedBox(width: 12.w),
                  itemBuilder: (_, index) {
                    return Container(
                      width: 165.w,
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
                            height: 140.h,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

