import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/color_manager.dart';

class CustomSnackBar {
  static void showSuccess(BuildContext context, String message) {
    _show(context, message, ColorM.success, Icons.check_circle_outline);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, ColorM.danger, Icons.error_outline);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message, ColorM.warning, Icons.warning_amber_rounded);
  }

  static void _show(
    BuildContext context,
    String message,
    Color accentColor,
    IconData icon,
  ) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorM.surfaceDarkElevated,
        elevation: 4,
        margin: EdgeInsets.all(16.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: accentColor.withValues(alpha: 0.5), width: 1),
        ),
        content: Row(
          children: [
            Icon(icon, color: accentColor, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorM.textPrimaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}