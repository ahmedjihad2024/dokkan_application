import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/widgets/feedback/app_error_widget.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../cubit/manage_products_cubit.dart';
import '../cubit/manage_products_state.dart';
import 'delete_product_dialog.dart';
import 'manage_products_action_row.dart';
import 'manage_products_empty_state.dart';
import 'manage_products_list_view.dart';
import 'manage_products_shimmer.dart';

class ManageProductsBody extends StatelessWidget {
  final VoidCallback? onAddProductPressed;
  final ValueChanged<ProductEntity>? onEditProduct;

  const ManageProductsBody({
    super.key,
    this.onAddProductPressed,
    this.onEditProduct,
  });

  Future<void> _handleDelete(
    BuildContext context,
    ManageProductsCubit cubit,
    ProductEntity product,
  ) async {
    final confirmed = await DeleteProductDialog.show(context, product);
    if (confirmed == true && context.mounted) {
      cubit.deleteProduct(product.id);
    }
  }

  Future<void> _handleEdit(
    BuildContext context,
    ManageProductsCubit cubit,
    ProductEntity product,
  ) async {
    if (onEditProduct != null) {
      onEditProduct!(product);
      return;
    }
    final result = await Navigator.pushNamed(
      context,
      Routes.addProduct,
      arguments: product,
    );
    if (result == true && context.mounted) {
      cubit.fetchProducts(isRefresh: true);
    }
  }

  Future<void> _handleAdd(
    BuildContext context,
    ManageProductsCubit cubit,
  ) async {
    if (onAddProductPressed != null) {
      onAddProductPressed!();
      return;
    }
    final result = await Navigator.pushNamed(context, Routes.addProduct);
    if (result == true && context.mounted) {
      cubit.fetchProducts(isRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageProductsCubit>();

    return BlocConsumer<ManageProductsCubit, ManageProductsState>(
      listenWhen: (_, current) => current is ManageProductsActionState,
      listener: (context, state) {
        if (state is ManageProductsActionSuccess) {
          CustomSnackBar.showSuccess(context, state.message, isTop: true);
        } else if (state is ManageProductsActionError) {
          CustomSnackBar.showError(context, state.message, isTop: true);
        }
      },
      buildWhen: (_, current) => current is! ManageProductsActionState,
      builder: (context, state) {
        final totalCount = state is ManageProductsActive ? state.totalCount : 0;

        return Column(
          children: [
            ManageProductsActionRow(
              itemCount: totalCount,
              onAddProduct: () => _handleAdd(context, cubit),
            ),
            Expanded(
              child: _ManageProductsContent(
                cubit: cubit,
                state: state,
                onProductTap: (product) => context.pushNamed(
                  Routes.productDetails,
                  arguments: product.id,
                ),
                onEdit: (product) => _handleEdit(context, cubit, product),
                onDelete: (product) => _handleDelete(context, cubit, product),
                onAddProduct: () => _handleAdd(context, cubit),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ManageProductsContent extends StatelessWidget {
  final ManageProductsCubit cubit;
  final ManageProductsState state;
  final ValueChanged<ProductEntity> onProductTap;
  final ValueChanged<ProductEntity> onEdit;
  final ValueChanged<ProductEntity> onDelete;
  final VoidCallback onAddProduct;

  const _ManageProductsContent({
    required this.cubit,
    required this.state,
    required this.onProductTap,
    required this.onEdit,
    required this.onDelete,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    if (state is ManageProductsInitial || state is ManageProductsLoading) {
      return const ManageProductsShimmer();
    }

    if (state is ManageProductsError) {
      final errorState = state as ManageProductsError;
      return AppErrorWidget(
        message: errorState.message,
        onRetry: () => cubit.fetchProducts(),
      );
    }

    if (state is ManageProductsEmpty) {
      return CustomizedSmartRefresh(
        controller: cubit.refreshController,
        onRefresh: () => cubit.fetchProducts(isRefresh: true),
        enableRefresh: true,
        enableLoading: false,
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          children: [
            ManageProductsEmptyState(onAddProduct: onAddProduct),
          ],
        ),
      );
    }

    if (state is ManageProductsActive) {
      final activeState = state as ManageProductsActive;

      return ManageProductsListView(
        products: activeState.products,
        deletingProductId: activeState.deletingProductId,
        refreshController: cubit.refreshController,
        hasNextPage: activeState.hasNextPage,
        onRefresh: () => cubit.fetchProducts(isRefresh: true),
        onLoading: cubit.loadMoreProducts,
        onProductTap: onProductTap,
        onEdit: onEdit,
        onDelete: onDelete,
      );
    }

    return const SizedBox.shrink();
  }
}
