import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class AddProductCategoryChips extends StatelessWidget {
  final Set<String> selectedCategories;
  final ValueChanged<String> onCategoryToggled;

  static const List<String> availableCategories = [
    'Watches',
    'Bags',
    'Jewelry',
    'Eyewear',
  ];

  const AddProductCategoryChips({
    super.key,
    required this.selectedCategories,
    required this.onCategoryToggled,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final primaryAccent =
        isDark ? const Color(0xFFD47A4A) : const Color(0xFFB85C36);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label matching Figma 37:816 / 37:887
        Text(
          'Category Selection (Multi-Select)',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: context.textSecondaryColor,
          ),
        ),
        SizedBox(height: 8.h),

        // Chips Row matching Figma 37:817 / 37:888
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: availableCategories.map((category) {
            final isSelected = selectedCategories.contains(category);

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onCategoryToggled(category),
                borderRadius: BorderRadius.circular(17.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryAccent : context.surfaceColor,
                    borderRadius: BorderRadius.circular(17.r),
                    border: Border.all(
                      color: isSelected ? primaryAccent : context.borderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.check,
                          size: 13.sp,
                          color: ColorM.white,
                        ),
                        SizedBox(width: 4.w),
                      ],
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? ColorM.white
                              : context.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
