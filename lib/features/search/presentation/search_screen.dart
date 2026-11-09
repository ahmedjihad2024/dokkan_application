import 'package:dokkan/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/shared/domain/model/product_entity.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_state.dart';
import 'widgets/search_filter_panel.dart';
import 'widgets/search_grid.dart';
import 'widgets/search_input_field.dart';
import 'widgets/search_shimmer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

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
          'Search & Discover',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final isFilterOpen = _isFilterOpen(state);
          final activeCount = _activeFiltersCount(state);

          return Column(
            children: [
              // Search Input & Filter toggle bar
              Padding(
                padding: EdgeInsets.fromLTRB(
                  SizeM.pagePadding.w,
                  10.h,
                  SizeM.pagePadding.w,
                  8.h,
                ),
                child: SearchInputField(
                  controller: cubit.searchController,
                  onChanged: cubit.onSearchChanged,
                  onSubmitted: cubit.onSearchSubmitted,
                  onClear: cubit.clearSearch,
                  onToggleFilter: cubit.toggleFilterPanel,
                  isFilterOpen: isFilterOpen,
                  activeFiltersCount: activeCount,
                ),
              ),

              // Collapsible Filter Panel
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: isFilterOpen
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                          SizeM.pagePadding.w,
                          4.h,
                          SizeM.pagePadding.w,
                          12.h,
                        ),
                        child: SearchFilterPanel(
                          initialMinPrice: cubit.minPrice,
                          initialMaxPrice: cubit.maxPrice,
                          initialSortBy: cubit.sortBy,
                          initialSortOrder: cubit.sortOrder,
                          onApply: ({minPrice, maxPrice, sortBy, sortOrder}) {
                            cubit.applyFilters(
                              minPrice: minPrice,
                              maxPrice: maxPrice,
                              sortBy: sortBy,
                              sortOrder: sortOrder,
                            );
                          },
                          onReset: cubit.resetFilters,
                          onHide: cubit.toggleFilterPanel,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // Active Filter Tags Row
              if (activeCount > 0) _buildActiveFilterChips(context, cubit),

              // Main Body Content
              Expanded(child: _buildBody(context, cubit, state)),
            ],
          );
        },
      ),
    );
  }

  bool _isFilterOpen(SearchState state) {
    if (state is SearchActive) return state.isFilterPanelOpen;
    if (state is SearchEmpty) return state.isFilterPanelOpen;
    if (state is SearchError) return state.isFilterPanelOpen;
    return false;
  }

  int _activeFiltersCount(SearchState state) {
    if (state is SearchActive) return state.activeFiltersCount;
    return 0;
  }

  Widget _buildActiveFilterChips(BuildContext context, SearchCubit cubit) {
    final chips = <Widget>[];

    if (cubit.minPrice != null) {
      chips.add(
        _buildChip(
          context,
          icon: Icons.payments_outlined,
          label: 'Min: \$${cubit.minPrice}',
          onDeleted: cubit.removeMinPrice,
        ),
      );
    }

    if (cubit.maxPrice != null) {
      chips.add(
        _buildChip(
          context,
          icon: Icons.payments_outlined,
          label: 'Max: \$${cubit.maxPrice}',
          onDeleted: cubit.removeMaxPrice,
        ),
      );
    }

    if (cubit.sortBy != null) {
      String sortLabel = cubit.sortBy!.value;
      for (final option in kSortOptions) {
        if (option.sortBy == cubit.sortBy &&
            option.sortOrder == cubit.sortOrder) {
          sortLabel = option.label;
          break;
        }
      }
      chips.add(
        _buildChip(
          context,
          icon: Icons.swap_vert_rounded,
          label: sortLabel,
          onDeleted: cubit.removeSorting,
        ),
      );
    }

    chips.add(
      GestureDetector(
        onTap: cubit.resetFilters,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.redAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.restart_alt_rounded,
                size: 13.sp,
                color: Colors.redAccent,
              ),
              SizedBox(width: 4.w),
              Text(
                'Clear all',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      height: 34.h,
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: chips.length,
        separatorBuilder: (_, _) => SizedBox(width: 6.w),
        itemBuilder: (_, index) => chips[index],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onDeleted,
  }) {
    final isDark = context.isDark;

    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 6.w, 4.h),
      decoration: BoxDecoration(
        color: ColorM.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorM.primary.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: ColorM.primary),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onDeleted,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isDark
                    ? ColorM.surfaceDarkElevated
                    : ColorM.surfaceLightElevated,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 11.sp,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    SearchCubit cubit,
    SearchState state,
  ) {
    if (state is SearchLoading) {
      return const SearchShimmer();
    }

    if (state is SearchError) {
      return ReqStateWidget(
        state: ReqState.failure,
        errorMessage: state.message,
        onRetry: () => cubit.fetchProducts(isRefresh: true),
        onSuccess: (_) => const SizedBox.shrink(),
      );
    }

    if (state is SearchEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 56.sp,
                color: context.textSecondaryColor.withValues(alpha: 0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                state.searchTerm != null && state.searchTerm!.isNotEmpty
                    ? 'No products found for "${state.searchTerm}"'
                    : 'No products match your criteria',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Try adjusting your search query or reset active filters.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.textSecondaryColor,
                ),
              ),
              if (state.hasActiveFilters) ...[
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: cubit.resetFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorM.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: const Text('Reset Filters'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (state is SearchActive) {
      final products = state.products;

      return CustomizedSmartRefresh(
        controller: cubit.refreshController,
        enableRefresh: true,
        enableLoading: state.hasNextPage,
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
                  '${state.totalCount} products found',
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
                onFavoriteToggle: context.read<FavoritesCubit>().toggleFavorite,
              ),
            ),

            // Bottom spacing
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
