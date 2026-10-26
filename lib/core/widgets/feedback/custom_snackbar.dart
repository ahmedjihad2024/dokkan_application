import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/color_manager.dart';

class CustomSnackBar {
  static void showSuccess(
    BuildContext context,
    String message, {
    bool isTop = false,
    double? topOffset,
  }) {
    _show(
      context,
      message,
      ColorM.success,
      Icons.check_circle_outline,
      isTop: isTop,
      topOffset: topOffset,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    bool isTop = false,
    double? topOffset,
  }) {
    _show(
      context,
      message,
      ColorM.danger,
      Icons.error_outline,
      isTop: isTop,
      topOffset: topOffset,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    bool isTop = false,
    double? topOffset,
  }) {
    _show(
      context,
      message,
      ColorM.warning,
      Icons.warning_amber_rounded,
      isTop: isTop,
      topOffset: topOffset,
    );
  }

  static void _show(
    BuildContext context,
    String message,
    Color accentColor,
    IconData icon, {
    bool isTop = false,
    double? topOffset,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();

    final mediaQuery = MediaQuery.maybeOf(context);
    final topPadding = mediaQuery?.padding.top ?? 0.0;
    final screenHeight = mediaQuery?.size.height ?? 800.0;
    final hasAppBar = Scaffold.maybeOf(context)?.hasAppBar ?? false;

    // Calculate safe top clearance so the snack bar never overlaps the status bar or notch.
    // When an AppBar is present, position right below it; otherwise add safe clearance from status bar.
    final defaultTopClearance = topPadding + (hasAppBar ? 60.h : 16.h);
    final effectiveTop = topOffset ?? defaultTopClearance;
    final snackBarHeight = 52.h;

    final bottomMargin = isTop
        ? (screenHeight - effectiveTop - snackBarHeight).clamp(0.0, double.infinity)
        : 16.r;

    final margin = isTop
        ? EdgeInsets.only(
            bottom: bottomMargin,
            left: 16.w,
            right: 16.w,
          )
        : EdgeInsets.all(16.r);

    scaffoldMessenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorM.surfaceDarkElevated,
        elevation: 4,
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        dismissDirection: isTop ? DismissDirection.up : DismissDirection.down,
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