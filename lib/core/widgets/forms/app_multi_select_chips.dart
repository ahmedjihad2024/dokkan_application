import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/gen/assets.gen.dart';

class AppMultiSelectChips<T> extends StatelessWidget {
  final String? label;
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemLabel;
  final void Function(T item) onToggle;
  final bool isRequired;

  const AppMultiSelectChips({
    super.key,
    this.label,
    required this.items,
    required this.selectedItems,
    required this.itemLabel,
    required this.onToggle,
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
          SizedBox(height: 10.h),
        ],
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return InkWell(
              onTap: () => onToggle(item),
              borderRadius: BorderRadius.circular(20.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorM.primary
                      : context.surfaceElevatedColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? ColorM.primary : context.borderColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Assets.svg.iconCheck.svg(
                        width: 14.w,
                        height: 14.w,
                        colorFilter: const ColorFilter.mode(
                          ColorM.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.w),
                    ],
                    Text(
                      itemLabel(item),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? ColorM.white
                            : context.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
