import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';

class CheckoutProgressBar extends StatelessWidget {
  final int currentStep; // 1 = Address, 2 = Payment, 3 = Review

  const CheckoutProgressBar({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StepNode(
            stepNumber: 1,
            title: 'Address',
            currentStep: currentStep,
          ),
          _Connector(isPassed: currentStep > 1),
          _StepNode(
            stepNumber: 2,
            title: 'Payment',
            currentStep: currentStep,
          ),
          _Connector(isPassed: currentStep > 2),
          _StepNode(
            stepNumber: 3,
            title: 'Review',
            currentStep: currentStep,
          ),
        ],
      ),
    );
  }
}

class _StepNode extends StatelessWidget {
  final int stepNumber;
  final String title;
  final int currentStep;

  const _StepNode({
    required this.stepNumber,
    required this.title,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = stepNumber < currentStep;
    final bool isActive = stepNumber == currentStep;

    Color circleColor;
    Color iconColor;
    if (isCompleted) {
      circleColor = ColorM.success;
      iconColor = Colors.white;
    } else if (isActive) {
      circleColor = ColorM.primaryDark;
      iconColor = Colors.white;
    } else {
      circleColor = context.surfaceElevatedColor;
      iconColor = context.textSecondaryColor;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted || isActive
                  ? circleColor
                  : context.borderColor,
              width: 1,
            ),
          ),
          child: isCompleted
              ? Icon(Icons.check, size: 14.sp, color: iconColor)
              : Text(
                  '$stepNumber',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
        ),
        6.horizontalSpace,
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive
                ? context.textPrimaryColor
                : context.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class _Connector extends StatelessWidget {
  final bool isPassed;

  const _Connector({required this.isPassed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 2.h,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: isPassed ? ColorM.success : context.borderColor,
        borderRadius: BorderRadius.circular(1.r),
      ),
    );
  }
}
