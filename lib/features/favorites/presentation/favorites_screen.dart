import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/shared/domain/model/product_entity.dart';
import 'cubit/favorites_cubit.dart';
import 'cubit/favorites_state.dart';
import 'widgets/favorites_empty_widget.dart';
import 'widgets/favorites_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();

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
          'My Wishlist',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded && state.products.isNotEmpty) {
            final products = state.products;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Count header
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    SizeM.pagePadding.w,
                    14.h,
                    SizeM.pagePadding.w,
                    8.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${products.length} ${products.length == 1 ? 'item' : 'items'} saved',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: context.textSecondaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorM.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'In Stock',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorM.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2-Column Products Grid
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeM.pagePadding.w,
                    vertical: 6.h,
                  ),
                  sliver: FavoritesGrid(
                    products: products,
                    onProductTap: (ProductEntity product) {
                      context.pushNamed(
                        Routes.productDetails,
                        arguments: product.id,
                      );
                    },
                    onAddToCart: (ProductEntity product) {
                      cubit.addToCart(product, context);
                    },
                    onFavoriteToggle: (String productId) {
                      cubit.removeFavorite(productId);
                    },
                  ),
                ),

                // Bottom Padding
                SliverToBoxAdapter(
                  child: SizedBox(height: 24.h),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.04, end: 0, curve: Curves.easeOutCubic);
          }

          // Empty state
          return const FavoritesEmptyWidget();
        },
      ),
    );
  }
}

