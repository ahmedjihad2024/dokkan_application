import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({super.key, this.userName = 'Alexander'});

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
      ],
    );
  }
}
