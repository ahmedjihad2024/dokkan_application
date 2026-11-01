import 'package:dokkan/features/checkout/data/models/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class OrderPaymentSummaryCard extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  final VoidCallback onChange;

  const OrderPaymentSummaryCard({
    super.key,
    required this.paymentMethod,
    required this.onChange,
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
      child: Row(
        children: [
          Text(
            paymentMethod.icon,
            style: TextStyle(fontSize: 20.sp),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentMethod.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                2.verticalSpace,
                Text(
                  paymentMethod.type == PaymentType.paymobCard
                      ? 'Visa ending in •••• 4242'
                      : paymentMethod.subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onChange,
            child: Text(
              'Change',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: ColorM.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

