import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/sizes_manager.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePaddingLarge.w),
        child: GridView.builder(
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
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56.r,
                    height: 56.r,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    width: 80.w,
                    height: 14.h,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: 50.w,
                    height: 10.h,
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

