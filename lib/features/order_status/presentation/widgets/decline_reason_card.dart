import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class DeclineReasonCard extends StatelessWidget {
  final String reason;

  const DeclineReasonCard({
    super.key,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.dangerContainerColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorM.danger.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 16.sp,
                color: ColorM.danger,
              ),
              6.horizontalSpace,
              Text(
                'Decline Details',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorM.danger,
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            reason,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.textPrimaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
