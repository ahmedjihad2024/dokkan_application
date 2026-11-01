import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';
import '../../../../core/res/sizes_manager.dart';

class CartOrderSummary extends StatelessWidget {
  final int totalCount;
  final double subtotal;

  const CartOrderSummary({
    super.key,
    required this.totalCount,
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeightM.semiBold,
            ),
          ),
          Gap(12.h),

          // Subtotal Row
          _row(
            label: 'Subtotal ($totalCount item${totalCount == 1 ? '' : 's'})',
            value: '\$${subtotal.toStringAsFixed(2)}',
            valueColor: context.textPrimaryColor,
            context: context,
          ),
          Gap(10.h),

          // Shipping Row
          _row(
            label: 'Standard Insured Shipping',
            value: 'FREE',
            valueColor: ColorM.success,
            context: context,
          ),
          Gap(12.h),

          Divider(height: 1, color: context.borderColor),
          Gap(12.h),

          // Estimated Total Row
          Row(
            children: [
              Expanded(
                child: Text(
                  'Estimated Total',
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeightM.bold,
                  ),
                ),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: TextStyle(
                  color: ColorM.primaryDark,
                  fontSize: 20.sp,
                  fontWeight: FontWeightM.bold,
                ),
              ),
            ],
          ),
          Gap(12.h),

          // Security Note
          Row(
            children: [
              Expanded(
                child: Text(
                  '256-bit encrypted checkout & complimentary 30-day returns',
                  style: TextStyle(
                    color: context.textMutedColor,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              Gap(6.w),
              Icon(
                Icons.lock_outline,
                size: 12.sp,
                color: context.textMutedColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row({
    required String label,
    required String value,
    required Color valueColor,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 12.sp,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 12.sp,
            fontWeight: FontWeightM.medium,
          ),
        ),
      ],
    );
  }
}

