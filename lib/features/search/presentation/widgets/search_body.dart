import 'package:dokkan/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/res/sizes_manager.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../../core/widgets/state/req_state_widget.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import 'search_empty_view.dart';
import 'search_grid.dart';
import 'search_shimmer.dart';

class SearchBody extends StatelessWidget {
  final SearchCubit cubit;
  final SearchState state;

  const SearchBody({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is SearchLoading) {
      return const SearchShimmer();
    }

    if (state is SearchError) {
      final errorState = state as SearchError;
      return ReqStateWidget(
        state: ReqState.failure,
        errorMessage: errorState.message,
        onRetry: () => cubit.fetchProducts(isRefresh: true),
        onSuccess: (_) => const SizedBox.shrink(),
      );
    }

    if (state is SearchEmpty) {
      final emptyState = state as SearchEmpty;
      return SearchEmptyView(
        searchTerm: emptyState.searchTerm,
        hasActiveFilters: emptyState.hasActiveFilters,
        onResetFilters: cubit.resetFilters,
      );
    }

    if (state is SearchActive) {
      final activeState = state as SearchActive;

      return CustomizedSmartRefresh(
        controller: cubit.refreshController,
        enableRefresh: true,
        enableLoading: activeState.hasNextPage,
        onRefresh: () => cubit.fetchProducts(isRefresh: true),
        onLoading: cubit.loadMoreProducts,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // Result count summary
            SliverPadding(
              padding: EdgeInsets.only(
                left: SizeM.pagePadding.w,
                right: SizeM.pagePadding.w,
                bottom: 8.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '${activeState.totalCount} products found',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: context.textSecondaryColor,
                  ),
                ),
              ),
            ),

            // Products 2-Column Grid
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeM.pagePadding.w,
                vertical: 6.h,
              ),
              sliver: SearchGrid(
                products: activeState.products,
                onProductTap: (ProductEntity product) {
                  context.pushNamed(
                    Routes.productDetails,
                    arguments: product.id,
                  );
                },
                onAddToCart: (ProductEntity product) {
                  cubit.addToCart(product, context);
                },
                onFavoriteToggle: context.read<FavoritesCubit>().toggleFavorite,
              ),
            ),

            // Bottom spacing
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
          .slideY(begin: 0.04, end: 0, curve: Curves.easeOutCubic);
    }

    return const SizedBox.shrink();
  }
}

