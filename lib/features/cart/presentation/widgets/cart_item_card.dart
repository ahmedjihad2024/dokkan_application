import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';
import '../../../../core/res/sizes_manager.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';
import '../../domain/model/cart_entity.dart';

class CartItemCard extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.productCoverUrl;
    final placeholder = Center(
      child: Icon(
        Icons.image_outlined,
        size: 30.sp,
        color: context.textMutedColor,
      ),
    );

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
          Container(
            width: 78.w,
            height: 78.w,
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: (imageUrl != null && imageUrl.isNotEmpty)
                ? CustomCachedImage(
                    imageUrl: imageUrl,
                    width: 78.w,
                    height: 78.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(12.r),
                    errorWidget: placeholder,
                  )
                : placeholder,
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeightM.semiBold,
                    color: context.textPrimaryColor,
                  ),
                ),
                4.verticalSpace,
                Row(
                  children: [
                    Text(
                      '\$${item.finalPricePerUnit.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    if (item.hasDiscount) ...[
                      6.horizontalSpace,
                      Text(
                        '\$${item.basePricePerUnit.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.textMutedColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                8.verticalSpace,
                Text(
                  '\$${item.totalPrice.toStringAsFixed(2)}',
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
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
  final VoidCallback? onTap;

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
        child: Opacity(
          opacity: onTap == null ? 0.35 : 1,
          child: Icon(
            icon,
            size: 13.sp,
            color: ColorM.textSecondaryLight,
          ),
        ),
      ),
    );
  }
}
