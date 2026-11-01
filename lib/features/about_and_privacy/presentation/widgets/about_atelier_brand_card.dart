import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/widgets/cards/surface_card.dart';

class AboutAtelierBrandCard extends StatelessWidget {
  const AboutAtelierBrandCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      width: double.infinity,
      backgroundColor: context.colorScheme.primary.withAlpha(30),
      borderColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          Assets.svg.iconAbout.svg(width: 32.r, height: 32.r),
          3.verticalSpace,
          Text(
            'DOKKAN ATELIER',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
              letterSpacing: 1.1,
            ),
          ),
          6.verticalSpace,
          Text(
            'Bespoke Accessories • Established 2018',
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

