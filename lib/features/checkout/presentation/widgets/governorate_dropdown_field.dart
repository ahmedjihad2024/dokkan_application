import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class GovernorateDropdownField extends StatelessWidget {
  final String? selectedGovernorate;
  final ValueChanged<String?> onChanged;

  const GovernorateDropdownField({
    super.key,
    required this.selectedGovernorate,
    required this.onChanged,
  });

  static const List<String> governorates = [
    'Cairo Governorate',
    'Giza Governorate',
    'Alexandria Governorate',
    'Qalyubia Governorate',
    'Sharqia Governorate',
    'Dakahlia Governorate',
    'Red Sea Governorate',
  ];

  static String normalize(String? value) {
    if (value == null || value.trim().isEmpty) return governorates.first;
    for (final gov in governorates) {
      if (gov.toLowerCase().contains(value.toLowerCase()) ||
          value.toLowerCase().contains(gov.toLowerCase())) {
        return gov;
      }
    }
    return governorates.first;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveValue = normalize(selectedGovernorate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State / Governorate',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: context.textSecondaryColor,
          ),
        ),
        6.verticalSpace,
        DropdownButtonFormField<String>(
          initialValue: effectiveValue,
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: context.textSecondaryColor,
            size: 22.sp,
          ),
          items: governorates.map((gov) {
            return DropdownMenuItem(
              value: gov,
              child: Text(
                gov,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: context.textPrimaryColor,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: context.surfaceColor,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: context.surfaceColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 13.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: context.borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: context.borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: ColorM.primaryDark,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

