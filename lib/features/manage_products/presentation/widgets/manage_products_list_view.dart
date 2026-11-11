import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/widgets/refresh/customized_smart_refresh.dart';
import 'manage_product_card.dart';

class ManageProductsListView extends StatelessWidget {
  final List<ProductEntity> products;
  final String? deletingProductId;
  final RefreshController refreshController;
  final bool hasNextPage;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final ValueChanged<ProductEntity>? onProductTap;
  final ValueChanged<ProductEntity> onEdit;
  final ValueChanged<ProductEntity> onDelete;

  const ManageProductsListView({
    super.key,
    required this.products,
    this.deletingProductId,
    required this.refreshController,
    required this.hasNextPage,
    required this.onRefresh,
    required this.onLoading,
    this.onProductTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomizedSmartRefresh(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enableRefresh: true,
      enableLoading: hasNextPage,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ManageProductCard(
            key: ValueKey(product.id),
            product: product,
            isDeleting: deletingProductId == product.id,
            onTap: onProductTap != null ? () => onProductTap!(product) : null,
            onEdit: () => onEdit(product),
            onDelete: () => onDelete(product),
          );
        },
      ),
    )
        .animate()
        .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.04, end: 0, curve: Curves.easeOutCubic);
  }
}
