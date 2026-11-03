import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/shared/domain/model/category_entity.dart';

class CollectionsSection extends StatelessWidget {
  final List<CategoryEntity> categories;
  final void Function(CategoryEntity model) onCategorySelected;
  final VoidCallback? onSeeAllPressed;
  final double horizontalPadding;

  const CollectionsSection({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.onSeeAllPressed,
    this.horizontalPadding = 20.0,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section Header Row matching Figma 37:351 with its own padding
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Collections',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
              GestureDetector(
                onTap: onSeeAllPressed,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'See all →',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorM.primary,
                  ),
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms, delay: 120.ms)
            .slideX(
              begin: -0.06,
              end: 0,
              curve: Curves.easeOutCubic,
            ),

        SizedBox(height: 12.h),

        // Horizontal Filter Chips scrolling edge-to-edge with staggered chip animation
        SizedBox(
          height: 36.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final category = categories[index];

              return InkWell(
                onTap: () => onCategorySelected(category),
                borderRadius: BorderRadius.circular(20.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: context.borderColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:context.textSecondaryColor,
                      ),
                    ),
                  ),
                ),
              )
                  .animate(delay: (150 + ((index % 5) * 60)).ms)
                  .fadeIn(
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .slideX(
                    begin: 0.2,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  );
            },
          ),
        ),
      ],
    );
  }
}
