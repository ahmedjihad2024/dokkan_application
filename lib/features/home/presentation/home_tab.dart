import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import '../../main_layout/presentation/cubit/layout_cubit.dart';
import '../../main_layout/presentation/cubit/layout_state.dart';
import 'widgets/collections_section.dart';
import 'widgets/curated_arrivals_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_promo_banner.dart';

class HomeTab extends StatefulWidget {
  final LayoutState state;
  final LayoutCubit cubit;

  const HomeTab({super.key, required this.state, required this.cubit});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    return ReqStateWidget(
      state: widget.state.status,
      errorMessage: widget.state.errorMessage,
      onRetry: widget.cubit.loadHomeData,
      onLoading: (_) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
        ),
      ),
      onFailure: (context, error) => AppErrorWidget(
        message: error ?? 'Failed to load curated pieces',
        onRetry: widget.cubit.loadHomeData,
      ),
      onEmpty: (context) => Center(
        child: Text(
          'No pieces currently available in the atelier',
          style: TextStyle(fontSize: 14.sp, color: context.textSecondaryColor),
        ),
      ),
      onSuccess: (context) => CustomizedSmartRefresh(
        refreshStyle: RefreshStyle.Front,
        controller: _refreshController,
        onRefresh: _handleRefresh,
        enableRefresh: true,
        enableLoading: false,
        child: ListView(
          padding: EdgeInsets.only(bottom: 24.h),
          children: [
            SizedBox(height: 12.h),

            // Header (Dokkan Atelier + Alexander greeting + Theme Switcher)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const HomeHeader(userName: 'Alexander'),
            ),

            SizedBox(height: 20.h),

            // Hero Banner (Season Atelier Leather promo carousel)
            HomePromoBanner(
              banners: widget.state.banners,
              activeIndex: widget.state.activeBannerIndex,
              onPageChanged: widget.cubit.updateBannerIndex,
            ),

            SizedBox(height: 22.h),

            // Collections category filter pills (scrolls edge-to-edge)
            CollectionsSection(
              categories: widget.state.categories,
              selectedCategoryId: '',
              onCategorySelected: (model) {
                context.pushNamed(Routes.productsByCategory, arguments: model.name);
              },
              onSeeAllPressed: () {
                context.pushNamed(Routes.categories);
              },
            ),

            SizedBox(height: 22.h),

            // Curated Arrivals product cards
            CuratedArrivalsSection(
              products: widget.state.products,
              onProductTap: (product) {
                context.pushNamed(Routes.productDetails, arguments: product);
              },
              onFavoriteToggle: widget.cubit.toggleFavorite,
              onAddToCart: (product) {
                widget.cubit.addToCart(product);
                CustomSnackBar.showSuccess(
                  context,
                  '${product.name} added to cart',
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
