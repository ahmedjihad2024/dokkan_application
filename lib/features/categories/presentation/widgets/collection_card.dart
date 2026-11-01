import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';
import '../../../../core/res/sizes_manager.dart';

class CollectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String itemCount;
  final IconData icon;
  final VoidCallback? onTap;

  const CollectionCard({
    super.key,
    this.title = 'Timepieces',
    this.subtitle = 'Automatic & quartz',
    this.itemCount = '50 Items',
    this.icon = Icons.access_time_rounded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: context.borderColor.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: const BoxDecoration(
                  color: ColorM.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: ColorM.backgroundDark,
                  size: 24.r,
                ),
              ),
              Gap(14.h),

              // Name
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeightM.black,
                  color: context.textPrimaryColor,
                  fontSize: 13.sp,
                ),
              ),
              Gap(2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeightM.thin,
                  color: context.textSecondaryColor,
                  fontSize: 11.sp,
                ),
              ),
              Gap(8.h),

              Container(
                decoration: BoxDecoration(
                  color: context.surfaceElevatedColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Text(
                    itemCount,
                    style: TextStyle(
                      fontWeight: FontWeightM.bold,
                      color: ColorM.primary,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

