import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';

class EmptyCartView extends StatelessWidget {
  final VoidCallback onExplore;

  const EmptyCartView({
    super.key,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration Circle (Figma: 72x72, radius: 36)
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF29211C) : ColorM.primary50,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? const Color(0xFF4D382E) : ColorM.primary200,
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: ColorM.primary,
                size: 32,
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(
                  begin: const Offset(0.85, 0.85),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutBack,
                ),
            16.verticalSpace,

            // Title (Figma: 18sp Bold)
            Text(
              'Your Shopping Bag is Empty',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeightM.bold,
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 80.ms)
                .slideY(
                  begin: 0.12,
                  end: 0,
                  curve: Curves.easeOutCubic,
                ),
            10.verticalSpace,

            // Description (Figma: 13sp Regular, maxWidth 280)
            Container(
              constraints: BoxConstraints(maxWidth: 280.w),
              child: Text(
                'Explore our handcrafted collection of timepieces, leather goods, and bespoke accessories.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 140.ms)
                .slideY(
                  begin: 0.12,
                  end: 0,
                  curve: Curves.easeOutCubic,
                ),
            20.verticalSpace,

            // Explore Collections Button (Figma: 200x48, radius: 12)
            SizedBox(
              width: 200.w,
              height: 48.h,
              child: ElevatedButton(
                onPressed: onExplore,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorM.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Explore Collections',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightM.semiBold,
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 200.ms)
                .slideY(
                  begin: 0.12,
                  end: 0,
                  curve: Curves.easeOutCubic,
                ),
          ],
        ),
      ),
    );
  }
}
