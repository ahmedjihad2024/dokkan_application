import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/gen/assets.gen.dart';
import '../../res/sizes_manager.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isRequired;

  const AppDropdownField({
    super.key,
    this.label,
    this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              if (isRequired) ...[
                SizedBox(width: 4.w),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorM.danger,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
        ],
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          dropdownColor: context.isDark
              ? ColorM.surfaceDarkElevated
              : ColorM.white,
          icon: Assets.svg.iconChevronDown.svg(
            width: 18.w,
            height: 18.w,
            colorFilter: ColorFilter.mode(
              context.isDark ? ColorM.textMutedDark : ColorM.textMutedLight,
              BlendMode.srcIn,
            ),
          ),
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: context.textPrimaryColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.isDark
                  ? ColorM.textMutedDark
                  : ColorM.textMutedLight,
            ),
            filled: true,
            fillColor: context.surfaceElevatedColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 15.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: BorderSide(color: context.borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: BorderSide(color: context.borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: const BorderSide(color: ColorM.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
