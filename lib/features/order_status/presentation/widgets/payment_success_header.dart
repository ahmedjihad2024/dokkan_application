import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class PaymentSuccessHeader extends StatelessWidget {
  const PaymentSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Green Success Circle
        Container(
          width: 88.w,
          height: 88.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorM.success.withValues(alpha: 0.14),
          ),
          child: Center(
            child: Container(
              width: 58.w,
              height: 58.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorM.success,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 36.sp,
                color: Colors.white,
              ),
            ),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              duration: 450.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: 350.ms),
        20.verticalSpace,

        Text(
          'Order Placed Successfully!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms, delay: 100.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
        8.verticalSpace,

        Text(
          'Thank you for your purchase. We have received your payment and our master artisans are preparing your order.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.sp,
            color: context.textSecondaryColor,
            height: 1.45,
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms, delay: 150.ms),
      ],
    );
  }
}

