import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/forms/app_text_field.dart';

class AddProductFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextDirection? textDirection;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? textColor;
  final FontWeight? textWeight;

  const AddProductFormField({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.textDirection,
    this.keyboardType,
    this.inputFormatters,
    this.textColor,
    this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    final isMultiline = maxLines > 1;

    return AppTextField(
      label: label,
      hintText: hintText,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      isMultiline: isMultiline,
      minLines: isMultiline ? maxLines : 1,
      textDirection: textDirection,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      fillColor: context.surfaceColor,
      borderColor: context.borderColor,
      borderRadius: isMultiline ? 12 : 10,
      labelSpacing: 6.h,
      labelStyle: TextStyle(
        fontSize: 11.sp,
        fontWeight: isMultiline ? FontWeight.w500 : FontWeight.w600,
        color: context.textSecondaryColor,
      ),
      textStyle: TextStyle(
        fontSize: isMultiline ? 12.sp : 13.sp,
        fontWeight: textWeight ?? FontWeight.w400,
        color: textColor ?? context.textPrimaryColor,
        height: isMultiline ? 1.4 : 1.2,
      ),
      hintStyle: TextStyle(
        fontSize: isMultiline ? 12.sp : 13.sp,
        fontWeight: FontWeight.w400,
        color: context.isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
        height: isMultiline ? 1.4 : 1.2,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: isMultiline ? 10.h : 12.h,
      ),
    );
  }
}
