import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

import '../../../../core/res/gen/assets.gen.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback? onFavoriteTap;

  const HomeHeader({
    super.key,
    this.userName = 'Alexander',
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting Text Column matching Figma 37:337
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Overline Brand Title
              Text(
                    'DOKKAN ATELIER',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: ColorM.primary,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 350.ms)
                  .slideX(begin: -0.08, end: 0, curve: Curves.easeOutCubic),

              SizedBox(height: 4.h),

              // User Greeting with One-Time Luxury Golden Shimmer
              Text(
                    'Good morning, $userName',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.2,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 450.ms, delay: 100.ms)
                  .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic)
                  .shimmer(
                    delay: 450.ms,
                    duration: 1600.ms,
                    curve: Curves.fastEaseInToSlowEaseOut,
                    color: isDark
                        ? const Color.fromARGB(255, 0, 255, 187)
                        : const Color.fromARGB(255, 1, 153, 112),
                  ).scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                    duration: 450.ms,
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),

              SizedBox(height: 4.h),

              // Tagline / Subtitle
              Text(
                    "Discover today's curated accessories",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: context.textSecondaryColor,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 200.ms)
                  .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
            ],
          ),
        ),
        if (onFavoriteTap != null) ...[
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: onFavoriteTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: isDark
                    ? ColorM.surfaceDarkElevated
                    : ColorM.surfaceLightElevated,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? ColorM.borderDark.withValues(alpha: 0.6)
                      : ColorM.borderLight.withValues(alpha: 0.8),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Assets.svg.iconHeartFilled.svg(
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.danger,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 150.ms)
              .scale(
                begin: const Offset(0.85, 0.85),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: Curves.easeOutBack,
              ),
        ],
      ],
    );
  }
}
