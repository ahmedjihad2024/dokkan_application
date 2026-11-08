import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;
  final VoidCallback onToggleFilter;
  final bool isFilterOpen;
  final int activeFiltersCount;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
    required this.onToggleFilter,
    required this.isFilterOpen,
    this.activeFiltersCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: isDark ? ColorM.surfaceDark : ColorM.surfaceLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isFilterOpen
              ? ColorM.primary
              : (isDark
                  ? ColorM.borderDark.withValues(alpha: 0.6)
                  : ColorM.borderLight),
          width: isFilterOpen ? 1.4 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 14.w),
          Icon(
            Icons.search_rounded,
            size: 20.sp,
            color: ColorM.primary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: context.textPrimaryColor,
              ),
              decoration: InputDecoration(
                hintText: 'Search jewelry, timepieces & gifts...',
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: context.textSecondaryColor,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false,
                fillColor: Colors.transparent,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return GestureDetector(
                onTap: onClear,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? ColorM.surfaceDarkElevated
                          : ColorM.surfaceLightElevated,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 14.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 4.w),
          // Filter Toggle Button
          GestureDetector(
            onTap: onToggleFilter,
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              margin: EdgeInsets.only(right: 6.w),
              padding: EdgeInsets.symmetric(
                horizontal: activeFiltersCount > 0 ? 10.w : 9.w,
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: isFilterOpen || activeFiltersCount > 0
                    ? ColorM.primary
                    : (isDark
                        ? ColorM.surfaceDarkElevated
                        : ColorM.surfaceLightElevated),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: isFilterOpen || activeFiltersCount > 0
                    ? [
                        BoxShadow(
                          color: ColorM.primary.withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFilterOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.tune_rounded,
                    size: 16.sp,
                    color: isFilterOpen || activeFiltersCount > 0
                        ? Colors.white
                        : context.textPrimaryColor,
                  ),
                  if (activeFiltersCount > 0) ...[
                    SizedBox(width: 4.w),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '$activeFiltersCount',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          color: ColorM.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
