import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../data/models/manage_product_item.dart';
import '../data/repositories/manage_products_repository.dart';
import 'cubit/manage_products_cubit.dart';
import 'widgets/manage_products_app_bar.dart';
import 'widgets/manage_products_body.dart';

class ManageProductsScreen extends StatelessWidget {
  final List<ManageProductItem>? initialItems;
  final ManageProductsRepository? repository;
  final VoidCallback? onAddProductPressed;
  final ValueChanged<ManageProductItem>? onEditProduct;

  const ManageProductsScreen({
    super.key,
    this.initialItems,
    this.repository,
    this.onAddProductPressed,
    this.onEditProduct,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManageProductsCubit(
        repository: repository,
        initialItems: initialItems,
      ),
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: const ManageProductsAppBar(),
        body: ManageProductsBody(
          onAddProductPressed: onAddProductPressed,
          onEditProduct: onEditProduct,
        ),
      ),
    );
  }
}
