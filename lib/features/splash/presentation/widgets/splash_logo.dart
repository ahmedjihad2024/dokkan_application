import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';

class SplashLogo extends StatelessWidget {
  final bool isDark;

  const SplashLogo({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Updated Dokkan Shopping Cart Logo Image from Figma
        Container(
          width: 122.w,
          height: 122.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: Assets.images.appLogo.image(
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 24.h),
        // English + Arabic Brand Name
        Text(
          'Dokkan \u2022 \u062f\u0643\u0651\u0627\u0646',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: isDark ? ColorM.textPrimaryDark : ColorM.textPrimaryLight,
          ),
        ),
        SizedBox(height: 8.h),
        // Tagline matching Figma 2:862
        Text(
          'Curated Artisanal Accessories',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
            color: isDark ? ColorM.textSecondaryDark : ColorM.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}