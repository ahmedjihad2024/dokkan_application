import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/shared/domain/model/category_entity.dart';
import 'retry_error_banner.dart';

class AddProductCategoryChips extends StatelessWidget {
  final ReqState status;
  final List<CategoryEntity> categories;
  final String? errorMessage;
  final Set<String> selectedCategoryIds;
  final ValueChanged<String> onCategoryToggled;
  final VoidCallback onRetry;

  const AddProductCategoryChips({
    super.key,
    required this.status,
    required this.categories,
    this.errorMessage,
    required this.selectedCategoryIds,
    required this.onCategoryToggled,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final primaryAccent =
        isDark ? const Color(0xFFD47A4A) : const Color(0xFFB85C36);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Selection (Multi-Select)',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: context.textSecondaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        if (status.isLoading || status.isIdle)
          const _CategoriesLoadingRow()
        else if (status.isFailure)
          RetryErrorBanner(
            message: errorMessage ?? 'Failed to load categories',
            accentColor: primaryAccent,
            onRetry: onRetry,
          )
        else if (categories.isEmpty)
          Text(
            'No categories available',
            style: TextStyle(
              fontSize: 12.sp,
              color: context.textSecondaryColor,
            ),
          )
        else
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: categories.map((category) {
              final isSelected = selectedCategoryIds.contains(category.id);

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onCategoryToggled(category.id),
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
                          category.name,
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

class _CategoriesLoadingRow extends StatelessWidget {
  const _CategoriesLoadingRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(
        4,
        (index) => Container(
          width: (68 + index * 12).w,
          height: 30.h,
          decoration: BoxDecoration(
            color: context.surfaceElevatedColor,
            borderRadius: BorderRadius.circular(17.r),
            border: Border.all(color: context.borderColor),
          ),
        ),
      ),
    );
  }
}
