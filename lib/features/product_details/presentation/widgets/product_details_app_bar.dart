import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';

class ProductDetailsAppBar extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProductDetailsAppBar({
    super.key,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final buttonBg = context.surfaceSubtleColor;
    final buttonBorder = context.borderColor;
    final iconColor = context.textPrimaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: SizedBox(
        height: 52.h,
        child: Row(
          children: [
            // Back button (38x38, radius 19) matching Figma 37:510 / 37:570
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.pop(),
                borderRadius: BorderRadius.circular(19.r),
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: buttonBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: buttonBorder, width: 1),
                  ),
                  child: Assets.svg.iconBack.svg(
                    width: 16.w,
                    height: 16.w,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            SizedBox(width: 14.w),

            // Title "Product Details" matching Figma 37:512 / 37:572
            Expanded(
              child: Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                ),
              ),
            ),

            // Favorite Button (38x38, radius 19) matching Figma 37:513 / 37:573
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onFavoriteToggle,
                borderRadius: BorderRadius.circular(19.r),
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: buttonBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: buttonBorder, width: 1),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: isFavorite
                        ? Assets.svg.iconHeartFilled.svg(
                            key: const ValueKey('fav_filled'),
                            width: 18.w,
                            height: 18.w,
                            colorFilter: const ColorFilter.mode(
                              ColorM.danger,
                              BlendMode.srcIn,
                            ),
                          )
                        : Assets.svg.iconHeart.svg(
                            key: const ValueKey('fav_outline'),
                            width: 18.w,
                            height: 18.w,
                            colorFilter: ColorFilter.mode(
                              iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
