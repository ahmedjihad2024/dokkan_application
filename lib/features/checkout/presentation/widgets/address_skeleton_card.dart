import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';

class AddressSkeletonCard extends StatelessWidget {
  const AddressSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final skelColor = context.isDark
        ? const Color(0xFF1F2937)
        : const Color(0xFFE2E8F0);

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: skelColor,
                ),
              ),
              10.horizontalSpace,
              Container(
                width: 60.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: skelColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Container(
            width: 240.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: skelColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          8.verticalSpace,
          Container(
            width: 160.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: skelColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          10.verticalSpace,
          Container(
            width: 120.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: skelColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
