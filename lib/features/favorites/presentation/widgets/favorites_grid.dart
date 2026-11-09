import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/sizes_manager.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../home/presentation/widgets/product_card.dart';

class FavoritesGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final ValueChanged<ProductEntity>? onProductTap;
  final ValueChanged<ProductEntity>? onAddToCart;
  final ValueChanged<String>? onFavoriteToggle;

  const FavoritesGrid({
    super.key,
    required this.products,
    this.onProductTap,
    this.onAddToCart,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: SizeM.elementSpacing.w,
        mainAxisSpacing: SizeM.elementSpacing.h,
        childAspectRatio: 165 / 290,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return ProductCard(
            key: ValueKey(product.id),
            product: product,
            onFavoriteToggle: () => onFavoriteToggle?.call(product.id),
            onAddToCart: () => onAddToCart?.call(product),
            onTap: () => onProductTap?.call(product),
          )
              .animate(delay: ((index % 6) * 40).ms)
              .fadeIn(
                duration: 350.ms,
                curve: Curves.easeOutCubic,
              )
              .slideY(
                begin: 0.08,
                end: 0,
                duration: 350.ms,
                curve: Curves.easeOutCubic,
              )
              .scale(
                begin: const Offset(0.96, 0.96),
                end: const Offset(1, 1),
                duration: 350.ms,
                curve: Curves.easeOutCubic,
              );
        },
        childCount: products.length,
      ),
    );
  }
}

