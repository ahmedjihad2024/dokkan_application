import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';

class CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentStep;
  final VoidCallback onBack;

  const CheckoutAppBar({
    super.key,
    required this.currentStep,
    required this.onBack,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  String get _title {
    switch (currentStep) {
      case 0:
        return 'Select Delivery Address';
      case 1:
        return 'Payment Method';
      case 2:
      default:
        return 'Review Order';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: context.surfaceElevatedColor,
            shape: const CircleBorder(),
          ),
          onPressed: onBack,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16.sp,
            color: context.textPrimaryColor,
          ),
        ),
      ),
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: Text(
          _title,
          key: ValueKey<int>(currentStep),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}

