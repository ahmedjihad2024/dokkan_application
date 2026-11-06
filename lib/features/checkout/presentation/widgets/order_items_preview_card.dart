import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';
import '../../../cart/domain/model/cart_entity.dart';

class OrderItemsPreviewCard extends StatelessWidget {
  final List<CartItemEntity> items;
  final bool isLoading;

  const OrderItemsPreviewCard({
    super.key,
    required this.items,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      final isDark = context.isDark;
      return Skeletonizer(
        enabled: true,
        effect: ShimmerEffect(
          baseColor: isDark
              ? ColorM.surfaceDarkElevated
              : const Color(0xFFE9EDEE),
          highlightColor: isDark
              ? ColorM.surfaceDarkSubtle
              : const Color(0xFFF7F9FA),
          duration: const Duration(milliseconds: 1400),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: context.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bone.text(width: 120.w, fontSize: 13),
              12.verticalSpace,
              for (int i = 0; i < 3; i++) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    children: [
                      Bone.square(
                        size: 36.r,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Bone.text(width: 140.w, fontSize: 12),
                            4.verticalSpace,
                            Bone.text(width: 80.w, fontSize: 11),
                          ],
                        ),
                      ),
                      Bone.text(width: 50.w, fontSize: 12),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Items (${items.length})',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          12.verticalSpace,
          if (items.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Center(
                child: Text(
                  'No items found in your cart',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
              ),
            )
          else
            ...items.map((item) {
              final hasImage = item.productCoverUrl != null &&
                  item.productCoverUrl!.isNotEmpty;
              final specText = _buildSpecText(item);

              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.surfaceElevatedColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: hasImage
                          ? CustomCachedImage(
                              imageUrl: item.productCoverUrl!,
                              width: 36.w,
                              height: 36.w,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.circular(8.r),
                              errorWidget: Center(
                                child: Icon(
                                  Icons.error,
                                  size: 16.sp,
                                  color: context.textMutedColor,
                                ),
                              ),
                            )
                          : Center(
                              child: Icon(
                                  Icons.error,
                                  size: 16.sp,
                                  color: context.textMutedColor,
                                ),
                            ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: context.textPrimaryColor,
                            ),
                          ),
                          Text(
                            specText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  String _buildSpecText(CartItemEntity item) {
    final buffer = StringBuffer('${item.quantity}x');
    if (item.variant.isNotEmpty) {
      buffer.write(' • ${item.variant}');
    } else if (item.weightInGrams > 0) {
      buffer.write(' • ${item.weightInGrams.toStringAsFixed(0)}g');
    }
    return buffer.toString();
  }
}
