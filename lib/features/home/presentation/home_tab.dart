import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/shared/domain/model/category_entity.dart';
import '../../../core/shared/domain/model/product_entity.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'widgets/collections_section.dart';
import 'widgets/curated_arrivals_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_promo_banner.dart';
import 'widgets/home_shimmer_loading.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await context.read<HomeCubit>().init();
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onFavoriteToggle(String productId) {
    // Favorite toggle handling
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          _refreshController.refreshFailed();
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        // 1. Loading State -> Show Shimmer
        if (state is HomeLoading) {
          return const HomeShimmerLoading();
        }

        // 2. Error State -> Show Error Widget with retry button
        if (state is HomeError) {
          return AppErrorWidget(
            message: state.message,
            onRetry: () => context.read<HomeCubit>().init(),
          );
        }

        // 3. Success State -> Consume domain entities directly from state
        if (state is HomeSuccess) {

          return CustomizedSmartRefresh(
            controller: _refreshController,
            onRefresh: _handleRefresh,
            enableRefresh: true,
            enableLoading: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                // Header (Dokkan Atelier + Greeting)
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
                  sliver: const SliverToBoxAdapter(
                    child: HomeHeader(userName: 'Alexander'),
                  ),
                ),

                // Hero Banner -> Only added if there are offers in state
                if (state.offers.isNotEmpty)
                  SliverToBoxAdapter(
                    child: HomePromoBanner(
                      offers: state.offers,
                    )
                        .animate()
                        .fadeIn(duration: 450.ms, delay: 120.ms)
                        .slideY(
                          begin: 0.08,
                          end: 0,
                          curve: Curves.easeOutCubic,
                        ),
                  ),

                // Collections category filter pills (scrolls edge-to-edge)
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: state.offers.isNotEmpty ? 22.h : 8.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: CollectionsSection(
                      categories: state.categories,
                      onCategorySelected: (category) {
                        context.pushNamed(
                          Routes.productsByCategory,
                          arguments: category.name,
                        );
                      },
                      onSeeAllPressed: () {
                        context.pushNamed(Routes.categories);
                      },
                    ),
                  ),
                ),

                // Curated Arrivals product cards
                SliverPadding(
                  padding: EdgeInsets.only(top: 22.h),
                  sliver: SliverToBoxAdapter(
                    child: CuratedArrivalsSection(
                      products: state.products,
                      onProductTap: (ProductEntity product) {
                        context.pushNamed(
                          Routes.productDetails,
                          arguments: product,
                        );
                      },
                      onFavoriteToggle: _onFavoriteToggle,
                      onAddToCart: (ProductEntity product) {},
                    ),
                  ),
                ),

                // Bottom spacing sliver
                SliverToBoxAdapter(
                  child: SizedBox(height: 24.h),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
