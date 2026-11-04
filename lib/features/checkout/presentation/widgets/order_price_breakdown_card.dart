import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class OrderPriceBreakdownCard extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final bool isLoading;

  const OrderPriceBreakdownCard({
    super.key,
    required this.itemCount,
    required this.subtotal,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      final isDark = context.isDark;
      return Skeletonizer(
        enabled: true,
        effect: ShimmerEffect(
          baseColor: isDark
              ? ColorM.surfaceDarkElevated
              : const Color(0xFFE9EDEE),
          highlightColor: isDark
              ? ColorM.surfaceDarkSubtle
              : const Color(0xFFF7F9FA),
          duration: const Duration(milliseconds: 1400),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: context.borderColor),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bone.text(width: 130.w, fontSize: 12),
                  Bone.text(width: 55.w, fontSize: 12),
                ],
              ),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bone.text(width: 140.w, fontSize: 12),
                  Bone.text(width: 40.w, fontSize: 12),
                ],
              ),
              10.verticalSpace,
              Divider(height: 1, color: context.borderColor),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bone.text(width: 100.w, fontSize: 15),
                  Bone.text(width: 70.w, fontSize: 18),
                ],
              ),
              4.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: Bone.text(width: 150.w, fontSize: 10),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
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
