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
    'Cairo',
    'Giza',
    'Alexandria',
    'Dakahlia',
    'Red Sea',
    'Beheira',
    'Fayoum',
    'Gharbia',
    'Ismailia',
    'Menofia',
    'Minya',
    'Qaliubiya',
    'New Valley',
    'Suez',
    'Aswan',
    'Assiut',
    'Beni Suef',
    'Port Said',
    'Damietta',
    'Sharkia',
    'South Sinai',
    'Kafr Al sheikh',
    'Matrouh',
    'Luxor',
    'Qena',
    'North Sinai',
    'Sohag',
  ];

  static String? normalize(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final cleaned = raw.replaceAll('Governorate', '').trim().toLowerCase();
    for (final g in governorates) {
      if (g.toLowerCase() == cleaned || cleaned.contains(g.toLowerCase())) {
        return g;
      }
    }
    return governorates.first;
  }

  @override
  Widget build(BuildContext context) {
    final value = governorates.contains(selectedGovernorate)
        ? selectedGovernorate
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Governorate / State',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        8.verticalSpace,
        DropdownButtonFormField<String>(
          initialValue: value,
          dropdownColor: context.surfaceColor,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.textSecondaryColor,
          ),
          decoration: InputDecoration(
            hintText: 'Select governorate',
            hintStyle: TextStyle(
              fontSize: 13.sp,
              color: context.textSecondaryColor.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: context.surfaceColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: context.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: context.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: ColorM.primaryDark, width: 1.5),
            ),
          ),
          items: governorates.map((g) {
            return DropdownMenuItem<String>(
              value: g,
              child: Text(
                g,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.textPrimaryColor,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Please select a governorate';
            }
            return null;
          },
        ),
      ],
    );
  }
}

