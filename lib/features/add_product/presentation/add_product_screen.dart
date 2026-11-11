import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../core/shared/domain/model/product_entity.dart';
import 'widgets/add_product_app_bar.dart';
import 'widgets/add_product_body.dart';

class AddProductScreen extends StatelessWidget {
  final ProductEntity? product;
  final VoidCallback? onProductPublished;

  const AddProductScreen({
    super.key,
    this.product,
    this.onProductPublished,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AddProductAppBar(isEditMode: product != null),
      body: AddProductBody(onProductPublished: onProductPublished),
    );
  }
}
