import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/cards/surface_card.dart';

class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor:
            isDark ? ColorM.surfaceDarkElevated : const Color(0xFFE9EDEE),
        highlightColor:
            isDark ? ColorM.surfaceDarkSubtle : const Color(0xFFF7F9FA),
        duration: const Duration(milliseconds: 1400),
      ),
      child: SurfaceCard(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Bone.circle(size: 56.r),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(width: 140.w, fontSize: 16),
                  6.verticalSpace,
                  Bone.text(width: 185.w, fontSize: 12),
                  8.verticalSpace,
                  Bone(
                    width: 86.w,
                    height: 20.h,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

