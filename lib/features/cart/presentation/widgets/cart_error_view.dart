import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';

class CartErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CartErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: ColorM.danger,
            ),
            16.verticalSpace,
            Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeightM.bold,
              ),
            ),
            10.verticalSpace,
            Container(
              constraints: BoxConstraints(maxWidth: 280.w),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
            ),
            20.verticalSpace,
            SizedBox(
              width: 200.w,
              height: 48.h,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorM.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightM.semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
