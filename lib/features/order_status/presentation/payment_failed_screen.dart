import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import 'widgets/decline_reason_card.dart';
import 'widgets/payment_failed_action_buttons.dart';
import 'widgets/payment_failed_header.dart';

class PaymentFailedScreen extends StatelessWidget {
  final String? failureReason;

  const PaymentFailedScreen({super.key, this.failureReason});

  @override
  Widget build(BuildContext context) {
    final reason = failureReason ??
        'Transaction declined by issuing bank (3D Secure authentication timed out or insufficient funds). Please retry or select another card.';

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Header with error icon and title
                const PaymentFailedHeader(),
                24.verticalSpace,

                // Extracted Decline Reason Card Widget
                DeclineReasonCard(reason: reason)
                    .animate()
                    .fadeIn(duration: 450.ms, delay: 200.ms)
                    .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),

                const Spacer(),

                // Action buttons: Try Again & Back to Cart
                const PaymentFailedActionButtons(),
                16.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
