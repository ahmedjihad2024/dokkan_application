import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';

class CartOrderSummary extends StatelessWidget {
  final double subtotal;
  final int totalCount;
  final VoidCallback? onCheckout;

  const CartOrderSummary({
    super.key,
    required this.subtotal,
    required this.totalCount,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeightM.semiBold,
            ),
          ),
          12.verticalSpace,

          // Subtotal Row
          CartOrderSummaryRow(
            label: 'Subtotal ($totalCount item${totalCount == 1 ? '' : 's'})',
            value: '\$${subtotal.toStringAsFixed(2)}',
            valueColor: context.textPrimaryColor,
          ),
          10.verticalSpace,

          // Shipping Row
          const CartOrderSummaryRow(
            label: 'Standard Insured Shipping',
            value: 'FREE',
            valueColor: ColorM.success,
          ),
          12.verticalSpace,

          Divider(height: 1, color: context.borderColor),
          12.verticalSpace,

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
          12.verticalSpace,

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
              6.horizontalSpace,
              Icon(
                Icons.lock_outline,
                size: 12.sp,
                color: context.textMutedColor,
              ),
            ],
          ),

          // Fixed bottom Checkout Button
          if (onCheckout != null) ...[
            16.verticalSpace,
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
                onPressed: onCheckout,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeightM.semiBold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${subtotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeightM.bold,
                          ),
                        ),
                        6.horizontalSpace,
                        Icon(Icons.arrow_forward_rounded, size: 16.sp),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CartOrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const CartOrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
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
