import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class AddProductSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onSubmit;

  const AddProductSubmitButton({
    super.key,
    this.isLoading = false,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final primaryAccent =
        isDark ? const Color(0xFFD47A4A) : const Color(0xFFB85C36);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onSubmit,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          height: 50.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primaryAccent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(ColorM.white),
                  ),
                )
              : Text(
                  'Save & Publish Product',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorM.white,
                    letterSpacing: 0.2,
                  ),
                ),
        ),
      ),
    );
  }
}
