import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class CheckoutBottomBar extends StatelessWidget {
  final int currentStep;
  final double total;
  final bool isPlacingOrder;
  final VoidCallback onContinue;
  final VoidCallback onPlaceOrder;

  const CheckoutBottomBar({
    super.key,
    required this.currentStep,
    required this.total,
    required this.isPlacingOrder,
    required this.onContinue,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(color: context.borderColor, width: 1),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.isDark
                ? ColorM.primaryDark
                : ColorM.textPrimaryLight,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
          ),
          onPressed: isPlacingOrder
              ? null
              : () {
                  if (currentStep == 2) {
                    onPlaceOrder();
                  } else {
                    onContinue();
                  }
                },
          child: _buttonContent(context),
        ),
      ),
    ).animate().fadeIn(duration: 350.ms);
  }

  Widget _buttonContent(BuildContext context) {
    if (currentStep == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Continue to Payment',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          8.horizontalSpace,
          Icon(Icons.arrow_forward_rounded, size: 18.sp),
        ],
      );
    }

    if (currentStep == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Continue to Order Review',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          8.horizontalSpace,
          Icon(Icons.arrow_forward_rounded, size: 18.sp),
        ],
      );
    }

    // Step 2: Place Order
    if (isPlacingOrder) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 18.w,
            height: 18.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          10.horizontalSpace,
          Text(
            'Placing Order...',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Place Order',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            6.horizontalSpace,
            Icon(Icons.lock_outline_rounded, size: 16.sp),
          ],
        ),
      ],
    );
  }
}

