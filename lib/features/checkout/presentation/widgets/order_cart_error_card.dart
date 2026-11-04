import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class OrderCartErrorCard extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const OrderCartErrorCard({
    super.key,
    this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: ColorM.danger.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorM.danger.withValues(alpha: 0.12),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 26.sp,
              color: ColorM.danger,
            ),
          ),
          12.verticalSpace,
          Text(
            'Failed to Load Order Items',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          6.verticalSpace,
          Text(
            errorMessage?.isNotEmpty == true
                ? errorMessage!
                : 'Unable to retrieve your cart items. Please check your connection and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.textSecondaryColor,
              height: 1.35,
            ),
          ),
          14.verticalSpace,
          SizedBox(
            height: 38.h,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.isDark
                    ? ColorM.primaryDark
                    : ColorM.textPrimaryLight,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                elevation: 0,
              ),
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, size: 16.sp),
              label: Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms);
  }
}

