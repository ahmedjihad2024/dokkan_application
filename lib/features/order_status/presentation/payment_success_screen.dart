import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import 'widgets/order_receipt_card.dart';
import 'widgets/payment_success_action_buttons.dart';
import 'widgets/payment_success_header.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Map<String, dynamic>? orderData;

  const PaymentSuccessScreen({super.key, this.orderData});

  @override
  Widget build(BuildContext context) {
    final orderId = orderData?['orderId'] as String? ?? '#DOK-98421';
    final total = (orderData?['total'] as num?)?.toDouble() ?? 574.00;
    final paymentMethod =
        orderData?['paymentMethod'] as String? ?? 'Paymob Card (•••• 4242)';

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

                // Header with success icon and title
                const PaymentSuccessHeader(),
                24.verticalSpace,

                // Extracted Order Receipt Card Widget
                OrderReceiptCard(
                  orderId: orderId,
                  paymentMethod: paymentMethod,
                  total: total,
                )
                    .animate()
                    .fadeIn(duration: 450.ms, delay: 200.ms)
                    .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),

                const Spacer(),

                // Action buttons: View Orders & Back to Home
                PaymentSuccessActionButtons(orderId: orderId),
                16.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
