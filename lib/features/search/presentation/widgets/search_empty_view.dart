import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class SearchEmptyView extends StatelessWidget {
  final String? searchTerm;
  final bool hasActiveFilters;
  final VoidCallback onResetFilters;

  const SearchEmptyView({
    super.key,
    required this.searchTerm,
    required this.hasActiveFilters,
    required this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 56.sp,
              color: context.textSecondaryColor.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              searchTerm != null && searchTerm!.isNotEmpty
                  ? 'No products found for "$searchTerm"'
                  : 'No products match your criteria',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Try adjusting your search query or reset active filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.textSecondaryColor,
              ),
            ),
            if (hasActiveFilters) ...[
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: onResetFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorM.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: const Text('Reset Filters'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

