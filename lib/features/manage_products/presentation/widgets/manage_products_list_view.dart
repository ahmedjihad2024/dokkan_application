import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../data/models/manage_product_item.dart';
import 'manage_product_card.dart';
import 'manage_products_empty_state.dart';

class ManageProductsListView extends StatelessWidget {
  final List<ManageProductItem> products;
  final RefreshController refreshController;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoading;
  final ValueChanged<ManageProductItem> onEdit;
  final ValueChanged<ManageProductItem> onDelete;
  final VoidCallback onAddProduct;

  const ManageProductsListView({
    super.key,
    required this.products,
    required this.refreshController,
    required this.onRefresh,
    this.onLoading,
    required this.onEdit,
    required this.onDelete,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    return CustomizedSmartRefresh(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enableRefresh: true,
      enableLoading: true,
      child: products.isEmpty
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              children: [
                ManageProductsEmptyState(onAddProduct: onAddProduct)
                    .animate()
                    .fadeIn(duration: 450.ms, delay: 100.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 450.ms,
                      curve: Curves.easeOutCubic,
                    ),
              ],
            )
          : ListView.builder(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return ManageProductCard(
                  key: ValueKey(item.id),
                  item: item,
                  onEdit: () => onEdit(item),
                  onDelete: () => onDelete(item),
                )
                    .animate(delay: (80 + (index * 55)).ms)
                    .fadeIn(
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .scale(
                      begin: const Offset(0.98, 0.98),
                      end: const Offset(1, 1),
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    );
              },
            ),
    );
  }
}
