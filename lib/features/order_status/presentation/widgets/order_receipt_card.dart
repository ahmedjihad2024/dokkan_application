import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class OrderReceiptCard extends StatelessWidget {
  final String orderId;
  final String paymentMethod;
  final double total;

  const OrderReceiptCard({
    super.key,
    required this.orderId,
    required this.paymentMethod,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          ReceiptRow(
            label: 'Order Reference',
            value: orderId,
            isBold: true,
            valueColor: ColorM.primaryDark,
          ),
          12.verticalSpace,
          ReceiptRow(
            label: 'Payment Method',
            value: paymentMethod,
          ),
          12.verticalSpace,
          const ReceiptRow(
            label: 'Estimated Delivery',
            value: '2 - 3 Business Days',
          ),
          12.verticalSpace,
          Divider(height: 1, color: context.borderColor),
          12.verticalSpace,
          ReceiptRow(
            label: 'Total Paid',
            value: '\$${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const ReceiptRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: context.textSecondaryColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor ?? context.textPrimaryColor,
          ),
        ),
      ],
    );
  }
}
