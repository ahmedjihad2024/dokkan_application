import 'package:dokkan/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/shared/domain/model/product_entity.dart';
import '../../favorites/domain/usecase/toggle_favorite_usecase.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'widgets/curated_arrivals_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_promo_banner.dart';
import 'widgets/home_search_bar_widget.dart';
import 'widgets/home_shimmer_loading.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
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

  void _onFavoriteToggle(ProductEntity product) {
    context.read<FavoritesCubit>().toggleFavorite(product);
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
                // Header (Dokkan Atelier + Greeting + Favorite Button)
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 14.h),
                  sliver: SliverToBoxAdapter(
                    child: HomeHeader(
                      userName: 'Alexander',
                      onFavoriteTap: () => context.pushNamed(Routes.favorites),
                    ),
                  ),
                ),

                // Search Bar Widget (Navigates to Search Screen on tap)
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 18.h),
                  sliver: SliverToBoxAdapter(
                    child: HomeSearchBarWidget(
                      onTap: () => context.pushNamed(Routes.search),
                    ),
                  ),
                ),

                // Hero Banner -> Only added if there are offers in state
                if (state.offers.isNotEmpty)
                  SliverToBoxAdapter(
                    child: HomePromoBanner(offers: state.offers)
                        .animate()
                        .fadeIn(duration: 450.ms, delay: 120.ms)
                        .slideY(
                          begin: 0.08,
                          end: 0,
                          curve: Curves.easeOutCubic,
                        ),
                  ),

                // Curated Arrivals product cards with See All button
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: state.offers.isNotEmpty ? 24.h : 12.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: CuratedArrivalsSection(
                      products: state.products,
                      onSeeAllPressed: () => context.pushNamed(Routes.search),
                      onProductTap: (ProductEntity product) {
                        context.pushNamed(
                          Routes.productDetails,
                          arguments: product.id,
                        );
                      },
                      onFavoriteToggle: _onFavoriteToggle,
                      onAddToCart: (ProductEntity product) {
                        context.read<HomeCubit>().addToCart(
                          product.id,
                          quantity: 1,
                          context: context,
                        );
                      },
                    ),
                  ),
                ),

                // Bottom spacing sliver
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
