import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/color_manager.dart';

class RetryErrorBanner extends StatelessWidget {
  final String message;
  final Color accentColor;
  final VoidCallback onRetry;

  const RetryErrorBanner({
    super.key,
    required this.message,
    required this.accentColor,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorM.danger.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorM.danger.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 11.5.sp,
                color: ColorM.danger,
              ),
            ),
          ),
          8.horizontalSpace,
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: accentColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

