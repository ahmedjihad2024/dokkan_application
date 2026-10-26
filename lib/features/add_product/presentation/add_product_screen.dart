import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/theme_extensions.dart';
import 'cubit/add_product_cubit.dart';
import 'widgets/add_product_app_bar.dart';
import 'widgets/add_product_body.dart';

class AddProductScreen extends StatelessWidget {
  final VoidCallback? onProductPublished;

  const AddProductScreen({super.key, this.onProductPublished});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddProductCubit(),
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: const AddProductAppBar(),
        body: AddProductBody(onProductPublished: onProductPublished),
      ),
    );
  }
}
