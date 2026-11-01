import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/sizes_manager.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/presentation/widgets/product_card.dart';

class ProductsByCategoryGrid extends StatelessWidget {
  final List<ProductModel> products;
  final ValueChanged<ProductModel>? onProductTap;

  const ProductsByCategoryGrid({
    super.key,
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: SizeM.elementSpacing.w,
        mainAxisSpacing: SizeM.elementSpacing.h,
        childAspectRatio: 165 / 290,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onFavoriteToggle: () {},
          onAddToCart: () {},
          onTap: () => onProductTap?.call(product),
        );
      },
    );
  }
}

