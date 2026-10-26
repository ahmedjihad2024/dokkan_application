import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/res/router/routes.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../data/models/manage_product_item.dart';
import '../cubit/manage_products_cubit.dart';
import '../cubit/manage_products_state.dart';
import 'delete_product_dialog.dart';
import 'manage_products_action_row.dart';
import 'manage_products_list_view.dart';

class ManageProductsBody extends StatefulWidget {
  final VoidCallback? onAddProductPressed;
  final ValueChanged<ManageProductItem>? onEditProduct;

  const ManageProductsBody({
    super.key,
    this.onAddProductPressed,
    this.onEditProduct,
  });

  @override
  State<ManageProductsBody> createState() => _ManageProductsBodyState();
}

class _ManageProductsBodyState extends State<ManageProductsBody> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await context.read<ManageProductsCubit>().refreshProducts();
    if (mounted) {
      _refreshController.refreshCompleted(resetFooterState: true);
    }
  }

  Future<void> _handleLoading() async {
    // Wait for 1 second timer, then mark loading complete as success
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _refreshController.loadComplete();
    }
  }

  Future<void> _handleDelete(ManageProductItem item) async {
    final confirmed = await DeleteProductDialog.show(context, item);
    if (confirmed == true && mounted) {
      context.read<ManageProductsCubit>().deleteProduct(item);
      CustomSnackBar.showSuccess(
        context,
        'Product deleted successfully',
        isTop: true,
      );
    }
  }

  void _handleEdit(ManageProductItem item) {
    if (widget.onEditProduct != null) {
      widget.onEditProduct!(item);
    } else {
      CustomSnackBar.showSuccess(context, 'Edit product: ${item.name}');
    }
  }

  void _handleAdd() {
    if (widget.onAddProductPressed != null) {
      widget.onAddProductPressed!();
    } else {
      Navigator.pushNamed(context, Routes.addProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageProductsCubit, ManageProductsState>(
      builder: (context, state) {
        return Column(
          children: [
            // Action Row matching Figma 37:636 / 37:701
            ManageProductsActionRow(
              itemCount: state.products.length,
              onAddProduct: _handleAdd,
            ),

            // Product List Container with Smart Pull-to-Refresh & Load More
            Expanded(
              child: ManageProductsListView(
                products: state.products,
                refreshController: _refreshController,
                onRefresh: _handleRefresh,
                onLoading: _handleLoading,
                onEdit: _handleEdit,
                onDelete: _handleDelete,
                onAddProduct: _handleAdd,
              ),
            ),
          ],
        );
      },
    );
  }
}
