import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/gen/assets.gen.dart';
import '../../res/sizes_manager.dart';

/// Unified Form Field for the entire Dokkan Atelier App.
/// 
/// Handles:
/// - Standard single-line inputs (Text, Number, Email, Phone)
/// - Passwords with built-in SVG eye toggle ([isPassword]: true)
/// - Multi-line textareas for descriptions & messages ([maxLines] > 1 or [isMultiline]: true)
/// - RTL / Arabic text direction ([textDirection]: TextDirection.rtl)
/// - Required indicator ([isRequired]: true)
/// - Full reactive Light & Dark (#0D1117) theme styling
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isPassword;
  final bool isMultiline;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final bool isRequired;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final Color? borderColor;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.initialValue,
    this.isPassword = false,
    this.isMultiline = false,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.isRequired = false,
    this.textDirection,
    this.inputFormatters,
    this.fillColor,
    this.borderColor,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveMaxLines = widget.isPassword
        ? 1
        : (widget.isMultiline ? (widget.maxLines ?? 5) : (widget.maxLines ?? 1));
    final effectiveMinLines = widget.isPassword
        ? 1
        : (widget.isMultiline ? (widget.minLines ?? 3) : (widget.minLines ?? 1));

    final effectiveKeyboardType = widget.keyboardType ??
        (widget.isMultiline
            ? TextInputType.multiline
            : (widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.text));

    final effectiveAction = widget.textInputAction ??
        (widget.isMultiline
            ? TextInputAction.newline
            : (widget.isPassword
                ? TextInputAction.done
                : TextInputAction.done));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Optional Label Row with Red Asterisk if Required
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              if (widget.isRequired) ...[
                SizedBox(width: 4.w),
                Text(
                  '*',
                  style: GoogleFonts.inter(
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

        // Input Box
        TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          obscureText: _obscureText,
          maxLines: effectiveMaxLines,
          minLines: effectiveMinLines,
          keyboardType: effectiveKeyboardType,
          textInputAction: effectiveAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          textDirection: widget.textDirection,
          inputFormatters: widget.inputFormatters,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: context.textPrimaryColor,
            height: effectiveMaxLines > 1 ? 1.45 : null,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.isDark ? ColorM.textMutedDark : ColorM.textMutedLight,
            ),
            filled: true,
            fillColor: widget.fillColor ?? context.surfaceElevatedColor,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: widget.prefixIcon != null
                ? BoxConstraints(minWidth: 44.w, minHeight: 44.w)
                : null,
            suffixIcon: _buildSuffixIcon(context),
            suffixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.w),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: effectiveMaxLines > 1 ? 14.h : 15.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? context.borderColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? context.borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: const BorderSide(color: ColorM.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: const BorderSide(color: ColorM.danger, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              borderSide: const BorderSide(color: ColorM.danger, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    // If password, render interactive SVG eye toggle
    if (widget.isPassword) {
      return IconButton(
        icon: _obscureText
            ? Assets.svg.iconEye.svg(
                width: 20.w,
                height: 20.w,
                colorFilter: ColorFilter.mode(
                  context.isDark ? ColorM.textMutedDark : ColorM.textMutedLight,
                  BlendMode.srcIn,
                ),
              )
            : Assets.svg.iconEyeOff.svg(
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.primary,
                  BlendMode.srcIn,
                ),
              ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    return widget.suffixIcon;
  }
}