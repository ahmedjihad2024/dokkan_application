import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class AddressErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const AddressErrorView({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76.w,
              height: 76.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorM.danger.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 36.sp,
                color: ColorM.danger,
              ),
            ),
            16.verticalSpace,
            Text(
              'Failed to Load Addresses',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
            ),
            8.verticalSpace,
            Text(
              'We couldn\'t retrieve your saved addresses. Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.textSecondaryColor,
                height: 1.4,
              ),
            ),
            20.verticalSpace,
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.isDark
                    ? ColorM.primaryDark
                    : ColorM.textPrimaryLight,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ).animate().fadeIn(duration: 400.ms),
      ),
    );
  }
}

