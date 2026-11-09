import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';

class FavoritesEmptyWidget extends StatelessWidget {
  const FavoritesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: ColorM.danger.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Assets.svg.iconHeartFilled.svg(
                width: 36.w,
                height: 36.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.danger,
                  BlendMode.srcIn,
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.7, 0.7),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(duration: 300.ms),
            SizedBox(height: 20.h),
            Text(
              'Your Wishlist is Empty',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Explore our curated collections and save items you love by tapping the heart icon.',
              style: TextStyle(
                fontSize: 13.sp,
                color: context.textSecondaryColor,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorM.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Explore Products',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

