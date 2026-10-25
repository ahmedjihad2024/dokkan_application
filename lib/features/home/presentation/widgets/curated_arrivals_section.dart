import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../data/models/product_model.dart';
import 'product_card.dart';

class CuratedArrivalsSection extends StatelessWidget {
  final List<ProductModel> products;
  final ValueChanged<ProductModel>? onProductTap;
  final ValueChanged<String>? onFavoriteToggle;
  final ValueChanged<ProductModel>? onAddToCart;
  final double horizontalPadding;

  const CuratedArrivalsSection({
    super.key,
    required this.products,
    this.onProductTap,
    this.onFavoriteToggle,
    this.onAddToCart,
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
        // Section Title matching Figma 37:365 with its own padding
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
          child: Text(
            'Curated Arrivals',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: context.textPrimaryColor,
            ),
          ),
        ),
        SizedBox(height: 14.h),

        // Horizontal Product List scrolling edge-to-edge with content padding
        SizedBox(
          height: 265.h,
          child: ListView.separated(
            key: Key("Curated Arrivals"),
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
                onFavoriteToggle: () => onFavoriteToggle?.call(product.id),
                onAddToCart: () => onAddToCart?.call(product),
              );
            },
          ),
        ),

        SizedBox(height: 18.h),
      ],
    );
  }
}
