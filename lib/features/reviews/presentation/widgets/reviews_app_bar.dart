import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';

class ReviewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String productName;
  final double averageRating;
  final int totalReviews;

  const ReviewsAppBar({
    super.key,
    required this.productName,
    this.averageRating = 4.9,
    this.totalReviews = 128,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    final primaryText = context.textPrimaryColor;
    final secondaryText = context.textSecondaryColor;
    final buttonBg = context.surfaceSubtleColor;
    final buttonBorder = context.borderColor;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        child: Row(
          children: [
            // Back button (38x38, radius 19)
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
                    colorFilter: ColorFilter.mode(primaryText, BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            SizedBox(width: 14.w),

            // Title & Product Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Customer Reviews',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                  Text(
                    productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ),

            // Rating Pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: buttonBg,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: buttonBorder, width: 1),
              ),
              child: Text(
                '★ ${averageRating.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorM.ratingGold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
