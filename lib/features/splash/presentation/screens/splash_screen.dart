import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/core/res/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashLogo extends StatelessWidget {
  final bool isDark;

  const SplashLogo({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/dokkan_logo.svg', 
          width: 122,
          height: 122,
        ),
        const SizedBox(height: 24),
        Text(
          'Dokkan • دكّان',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeightM.bold,
            color: isDark ? ColorM.productGradientLightStart : ColorM.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Curated Artisanal Accessories',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeightM.medium,
            color: isDark ? ColorM.textSecondaryLight : ColorM.textMutedLight,
          ),
        ),
      ],
    );
  }
}