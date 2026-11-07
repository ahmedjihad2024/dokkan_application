import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/sizes_manager.dart';
import '../../domain/model/category_entity.dart';
import 'collection_card.dart';

class CategoriesGrid extends StatelessWidget {
  final List<CategoryEntity> categories;
  final ValueChanged<CategoryEntity>? onCategoryTap;

  const CategoriesGrid({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: SizeM.elementSpacing.h,
        crossAxisSpacing: SizeM.elementSpacing.w,
        childAspectRatio: 0.95,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          return CollectionCard(
            category: category,
            onTap: () => onCategoryTap?.call(category),
          )
              .animate()
              .fadeIn(
                duration: 350.ms,
                delay: (index * 50).ms,
                curve: Curves.easeOutCubic,
              )
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1, 1),
                duration: 350.ms,
                delay: (index * 50).ms,
                curve: Curves.easeOutCubic,
              );
        },
        childCount: categories.length,
      ),
    );
  }
}
