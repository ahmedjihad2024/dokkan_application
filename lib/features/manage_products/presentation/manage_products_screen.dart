import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../core/shared/domain/model/product_entity.dart';
import 'widgets/manage_products_app_bar.dart';
import 'widgets/manage_products_body.dart';

class ManageProductsScreen extends StatelessWidget {
  final VoidCallback? onAddProductPressed;
  final ValueChanged<ProductEntity>? onEditProduct;

  const ManageProductsScreen({
    super.key,
    this.onAddProductPressed,
    this.onEditProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const ManageProductsAppBar(),
      body: ManageProductsBody(
        onAddProductPressed: onAddProductPressed,
        onEditProduct: onEditProduct,
      ),
    );
  }
}
