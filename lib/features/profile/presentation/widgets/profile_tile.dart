import 'package:dokkan/core/res/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/cards/surface_card.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
    this.titleColor,
    this.iconColor,
    this.iconBackgroundColor,
  });

  final String title;
  final SvgGenImage icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? titleColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          minTileHeight: 48.h,
          onTap: onTap,
          contentPadding: EdgeInsets.zero,

          leading: Container(
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(9.r),
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: icon.svg(width: 32, height: 32),
          ),

          title: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: titleColor ?? context.textPrimaryColor,
            ),
          ),

          trailing:
              trailing ??
              Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: iconColor ?? context.textMutedColor,
              ),
        ),
      ),
    );
  }
}
