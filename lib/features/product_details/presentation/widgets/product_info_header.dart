import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class ProductInfoHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double currentPrice;
  final double? originalPrice;
  final String? saveTag;
  final String materialText;
  final String weightText;
  final String stockText;
  final String description;

  const ProductInfoHeader({
    super.key,
    required this.title,
    this.subtitle = 'Product Code: DOK-9842 • 2-Year Official Warranty',
    required this.currentPrice,
    this.originalPrice = 199.00,
    this.saveTag,
    this.materialText = 'Espresso Leather',
    this.weightText = 'Weight: 142g',
    this.stockText = '● In Stock (8 left)',
    this.description =
        'Handcrafted Italian calfskin strap with 316L surgical steel and scratch-resistant sapphire crystal glass. 50m water resistant.',
  });

  @override
  Widget build(BuildContext context) {
    final primaryText = context.textPrimaryColor;
    final secondaryText = context.textSecondaryColor;
    final chipBg = context.surfaceElevatedColor;
    final chipTextColor = context.textSecondaryColor;
    final saveTagBg = context.dangerContainerColor;
    final stockTagBg = context.successContainerColor;

    // Compute save tag if not explicitly given
    String? calculatedSaveTag = saveTag;
    if (calculatedSaveTag == null &&
        originalPrice != null &&
        originalPrice! > currentPrice) {
      final diff = (originalPrice! - currentPrice).round();
      calculatedSaveTag = 'SAVE \$$diff';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title matching Figma 37:526 / 37:586
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
            height: 1.25,
          ),
        ),

        SizedBox(height: 4.h),

        // Product Code & Warranty matching Figma 37:527 / 37:587
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: secondaryText,
          ),
        ),

        SizedBox(height: 12.h),

        // Price Row matching Figma 37:528 / 37:588
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            // Current Price ($149.00)
            Text(
              '\$${currentPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: primaryText,
              ),
            ),

            if (originalPrice != null) ...[
              SizedBox(width: 8.w),
              // Original Price ($199.00)
              Text(
                '\$${originalPrice!.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.textMutedColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],

            if (calculatedSaveTag != null) ...[
              SizedBox(width: 10.w),
              // Save Tag (SAVE $50)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: saveTagBg,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  calculatedSaveTag,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorM.danger,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ],
        ),

        SizedBox(height: 12.h),

        // Attribute Chips Row matching Figma 37:533 / 37:593
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            // Material Chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: chipBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                materialText,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: chipTextColor,
                ),
              ),
            ),

            // Weight Chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: chipBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                weightText,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: chipTextColor,
                ),
              ),
            ),

            // Stock Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: stockTagBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                stockText,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorM.success,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),

        // Description text matching Figma 37:540 / 37:600
        Text(
          description,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: secondaryText,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
