import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import 'product_card.dart';

class CuratedArrivalsSection extends StatelessWidget {
  final List<ProductEntity> products;
  final ValueChanged<ProductEntity>? onProductTap;
  final ValueChanged<ProductEntity>? onFavoriteToggle;
  final ValueChanged<ProductEntity>? onAddToCart;
  final VoidCallback? onSeeAllPressed;
  final double horizontalPadding;

  const CuratedArrivalsSection({
    super.key,
    required this.products,
    this.onProductTap,
    this.onFavoriteToggle,
    this.onAddToCart,
    this.onSeeAllPressed,
    this.horizontalPadding = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Text(
            'No items in this collection yet',
            style: TextStyle(
              fontSize: 13.sp,
              color: context.textSecondaryColor,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section Header Row (Title + See All Button)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Curated Arrivals',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
              if (onSeeAllPressed != null)
                GestureDetector(
                  onTap: onSeeAllPressed,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorM.primary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 11.sp,
                          color: ColorM.primary,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms, delay: 200.ms)
            .slideX(
              begin: -0.06,
              end: 0,
              curve: Curves.easeOutCubic,
            ),

        SizedBox(height: 14.h),

        // Horizontal Product List scrolling edge-to-edge with staggered card animation
        SizedBox(
          height: 265.h,
          child: ListView.separated(
            key: const Key("Curated Arrivals"),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (_, _) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () => onProductTap?.call(product),
                onFavoriteToggle: () => onFavoriteToggle?.call(product),
                onAddToCart: () => onAddToCart?.call(product),
              )
                  .animate(delay: (150 + ((index % 3) * 50)).ms)
                  .fadeIn(
                    duration: 450.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .slideX(
                    begin: 0.15,
                    end: 0,
                    duration: 450.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                    duration: 450.ms,
                    curve: Curves.easeOutCubic,
                  );
            },
          ),
        ),
      ],
    );
  }
}
