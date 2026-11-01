import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';

class PaymentSuccessActionButtons extends StatelessWidget {
  final String orderId;

  const PaymentSuccessActionButtons({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // View My Orders Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
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
            onPressed: () {
              CustomSnackBar.showSuccess(
                context,
                'Order $orderId placed in your orders history',
              );
              context.pushNamedAndRemoveUntil(
                Routes.home,
                (_) => false,
              );
            },
            child: Text(
              'View My Orders',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 250.ms),
        10.verticalSpace,

        // Back to Home Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: context.textPrimaryColor,
              side: BorderSide(color: context.borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            onPressed: () {
              context.pushNamedAndRemoveUntil(
                Routes.home,
                (_) => false,
              );
            },
            child: Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 280.ms),
      ],
    );
  }
}

