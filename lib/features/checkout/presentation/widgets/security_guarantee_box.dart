import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class SecurityGuaranteeBox extends StatelessWidget {
  const SecurityGuaranteeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 18.sp,
            color: ColorM.primaryDark,
          ),
          10.horizontalSpace,
          Expanded(
            child: Text(
              'All transactions are secured with 256-bit SSL encryption. Dokkan never stores your sensitive CVV or card credentials.',
              style: TextStyle(
                fontSize: 11.sp,
                color: context.textSecondaryColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

