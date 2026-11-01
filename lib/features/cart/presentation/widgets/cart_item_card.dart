import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';
import '../../../../core/res/sizes_manager.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';
import '../../data/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image / Visual container (Figma: 78x78, radius: 12)
          Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                ? CustomCachedImage(
                    imageUrl: item.imageUrl!,
                    width: 78.w,
                    height: 78.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(12.r),
                    errorWidget: Center(
                      child: Text(
                        item.emoji,
                        style: TextStyle(fontSize: 32.sp),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      item.emoji,
                      style: TextStyle(fontSize: 32.sp),
                    ),
                  ),
          ),
          12.horizontalSpace,

          // Details column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeightM.semiBold,
                    color: context.textPrimaryColor,
                  ),
                ),
                4.verticalSpace,
                Text(
                  item.variant,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
                10.verticalSpace,
                Text(
                  '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightM.bold,
                    color: ColorM.primaryDark,
                  ),
                ),
              ],
            ),
          ),
          8.horizontalSpace,

          // Actions: Remove button & Stepper
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Remove button (Figma: 28x28 circle)
              InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  width: 28.w,
                  height: 28.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14.sp,
                    color: context.textMutedColor,
                  ),
                ),
              ),
              12.verticalSpace,

              // Quantity Stepper (Figma: 88x30, radius: 8)
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: context.surfaceElevatedColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CartStepperButton(
                      icon: Icons.remove,
                      onTap: onDecrement,
                    ),
                    Container(
                      width: 28.w,
                      alignment: Alignment.center,
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeightM.semiBold,
                          color: context.textPrimaryColor,
                        ),
                      ),
                    ),
                    CartStepperButton(
                      icon: Icons.add,
                      onTap: onIncrement,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartStepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CartStepperButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: SizedBox(
        width: 28.w,
        height: 30.h,
        child: Icon(
          icon,
          size: 13.sp,
          color: ColorM.textSecondaryLight,
        ),
      ),
    );
  }
}
