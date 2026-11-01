import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class OrderPriceBreakdownCard extends StatelessWidget {
  final int itemCount;
  final double subtotal;

  const OrderPriceBreakdownCard({
    super.key,
    required this.itemCount,
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          OrderPriceRow(
            label: 'Subtotal ($itemCount items)',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),
          8.verticalSpace,
          const OrderPriceRow(
            label: 'Insured Express Delivery',
            value: 'FREE',
            valueColor: ColorM.success,
          ),
          10.verticalSpace,
          Divider(height: 1, color: context.borderColor),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          4.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'VAT included where applicable',
              style: TextStyle(
                fontSize: 10.sp,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderPriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const OrderPriceRow({
    super.key,
    required this.label,
    required this.value,
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
            fontWeight: FontWeight.w600,
            color: valueColor ?? context.textPrimaryColor,
          ),
        ),
      ],
    );
  }
}

