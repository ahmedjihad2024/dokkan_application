import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/gen/assets.gen.dart';

class AppErrorAlert extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const AppErrorAlert({
    super.key,
    required this.message,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.isDark ? ColorM.dangerContainerDark : ColorM.dangerContainerLight,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorM.danger, width: 1),
      ),
      child: Row(
        children: [
          Assets.svg.iconWarning.svg(
            width: 18.w,
            height: 18.w,
            colorFilter: const ColorFilter.mode(
              ColorM.danger,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorM.danger,
              ),
            ),
          ),
          if (onDismiss != null) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: onDismiss,
              child: Assets.svg.iconClose.svg(
                width: 16.w,
                height: 16.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.danger,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}