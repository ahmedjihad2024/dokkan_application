import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import 'cubit/products_by_category_cubit.dart';
import 'cubit/products_by_category_state.dart';
import 'widgets/products_by_category_grid.dart';
import 'widgets/products_by_category_shimmer.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String? categoryId;
  final String? categoryTitle;

  const ProductsByCategoryScreen({
    super.key,
    this.categoryId,
    this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final title = categoryTitle ?? 'Products';
    final cubit = context.read<ProductsByCategoryCubit>();

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: context.textPrimaryColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
        builder: (context, state) {
          if (state is ProductsByCategoryLoading) {
            return const ProductsByCategoryShimmer();
          }

          if (state is ProductsByCategoryError) {
            return ReqStateWidget(
              state: ReqState.failure,
              errorMessage: state.message,
              onRetry: () => cubit.getProductsByCategory(isRefresh: true),
              onSuccess: (_) => const SizedBox.shrink(),
            );
          }

          if (state is ProductsByCategoryEmpty) {
            return ReqStateWidget(
              state: ReqState.empty,
              onRetry: () => cubit.getProductsByCategory(isRefresh: true),
              onSuccess: (_) => const SizedBox.shrink(),
            );
          }

          if (state is ProductsByCategoryActive) {
            final products = state.products;

            return CustomizedSmartRefresh(
              controller: cubit.refreshController,
              enableRefresh: true,
              enableLoading: state.hasNextPage,
              onRefresh: () => cubit.getProductsByCategory(isRefresh: true),
              onLoading: () => cubit.loadMoreProducts(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: 12.h,
                      left: SizeM.pagePadding.w,
                      right: SizeM.pagePadding.w,
                      bottom: 8.h,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        '${state.totalCount} Products',
                        style: TextStyle(
                          color: context.textSecondaryColor,
                          fontSize: 13.sp,
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePadding.w,
                      vertical: 8.h,
                    ),
                    sliver: ProductsByCategoryGrid(
                      products: products,
                      onProductTap: (product) {
                        context.pushNamed(
                          Routes.productDetails,
                          arguments: product.id,
                        );
                      },
                    ),
                  ),
                  if (state.isLoadingMore)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 24.h),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
