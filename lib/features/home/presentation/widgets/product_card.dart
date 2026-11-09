import 'package:dokkan/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteToggle,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final favCubit = context.read<FavoritesCubit>();

    return Container(
      width: 165.w,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.borderColor, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Product Image Visual Container
              Expanded(
                flex: 6,
                child: Container(
                  // height: 140.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? const [ColorM.surfaceDarkElevated, ColorM.surfaceDark]
                          : const [
                              ColorM.surfaceLightSubtle,
                              ColorM.surfaceLightElevated,
                            ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Center Visual / Product Image
                      if (product.coverPictureUrl != null &&
                          product.coverPictureUrl!.isNotEmpty)
                        Positioned.fill(
                          child: CustomCachedImage(
                            imageUrl: product.coverPictureUrl!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                            errorWidget: const Center(
                              child: Text(
                                '✨',
                                style: TextStyle(fontSize: 48),
                              ),
                            ),
                          ),
                        )
                      else
                        const Center(
                          child: Text(
                            '✨',
                            style: TextStyle(fontSize: 48),
                          ),
                        ),
                
                      // Discount Tag (Top-Left)
                      if (product.hasDiscount)
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorM.danger,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              '-${product.discountPercentage}%',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorM.white,
                              ),
                            ),
                          ),
                        ),
                
                      // Wishlist / Heart Button (Top-Right)
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: GestureDetector(
                          onTap: onFavoriteToggle,
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            width: 28.w,
                            height: 28.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: context.surfaceColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.borderColor,
                                width: 1,
                              ),
                            ),
                            child: favCubit.isFavroite(product.id)
                                ? Assets.svg.iconHeartFilled.svg(
                                    width: 14.w,
                                    height: 14.w,
                                    colorFilter: const ColorFilter.mode(
                                      ColorM.danger,
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : Assets.svg.iconHeart.svg(
                                    width: 14.w,
                                    height: 14.w,
                                    colorFilter: ColorFilter.mode(
                                      context.textSecondaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Product Info section
              Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Rating Row
                    Row(
                      children: [
                        Text(
                          '\u2605 ${product.rating.toStringAsFixed(1)} (${product.reviewsCount})',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorM.ratingGold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
              
                    // Product Title
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    // const Spacer(),
              
                    // Price and Quick Add Button Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Price column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${product.finalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: context.textPrimaryColor,
                                ),
                              ),
                              if (product.hasDiscount) ...[
                                SizedBox(height: 2.h),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: context.textSecondaryColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        // Quick Add "+" button
                        GestureDetector(
                          onTap: onAddToCart,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 32.w,
                            height: 32.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? ColorM.primary
                                  : ColorM.textPrimaryLight,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
