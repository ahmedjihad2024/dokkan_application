import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/sizes_manager.dart';
import '../cubit/search_cubit.dart';
import 'search_filter_panel.dart';

class SearchActiveFilterChips extends StatelessWidget {
  final SearchCubit cubit;

  const SearchActiveFilterChips({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (cubit.minPrice != null) {
      chips.add(
        _FilterChipItem(
          icon: Icons.payments_outlined,
          label: 'Min: \$${cubit.minPrice}',
          onDeleted: cubit.removeMinPrice,
        ),
      );
    }

    if (cubit.maxPrice != null) {
      chips.add(
        _FilterChipItem(
          icon: Icons.payments_outlined,
          label: 'Max: \$${cubit.maxPrice}',
          onDeleted: cubit.removeMaxPrice,
        ),
      );
    }

    if (cubit.sortBy != null) {
      String sortLabel = cubit.sortBy!.value;
      for (final option in kSortOptions) {
        if (option.sortBy == cubit.sortBy &&
            option.sortOrder == cubit.sortOrder) {
          sortLabel = option.label;
          break;
        }
      }
      chips.add(
        _FilterChipItem(
          icon: Icons.swap_vert_rounded,
          label: sortLabel,
          onDeleted: cubit.removeSorting,
        ),
      );
    }

    chips.add(_ClearFiltersChip(onTap: cubit.resetFilters));

    return Container(
      height: 34.h,
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: chips.length,
        separatorBuilder: (_, _) => SizedBox(width: 6.w),
        itemBuilder: (_, index) => chips[index],
      ),
    );
  }
}

class _ClearFiltersChip extends StatelessWidget {
  final VoidCallback onTap;

  const _ClearFiltersChip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.restart_alt_rounded,
              size: 13.sp,
              color: Colors.redAccent,
            ),
            SizedBox(width: 4.w),
            Text(
              'Clear all',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onDeleted;

  const _FilterChipItem({
    required this.icon,
    required this.label,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 6.w, 4.h),
      decoration: BoxDecoration(
        color: ColorM.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorM.primary.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: ColorM.primary),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onDeleted,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isDark
                    ? ColorM.surfaceDarkElevated
                    : ColorM.surfaceLightElevated,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 11.sp,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

