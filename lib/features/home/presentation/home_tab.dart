import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import '../data/models/category_model.dart';
import '../data/models/product_model.dart';
import '../data/models/promo_banner_model.dart';
import '../data/repositories/home_repository.dart';
import 'widgets/collections_section.dart';
import 'widgets/curated_arrivals_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_promo_banner.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final HomeRepository _repository = HomeRepositoryImpl();

  ReqState _status = ReqState.loading;
  List<PromoBannerModel> _banners = [];
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  int _activeBannerIndex = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _loadHomeData({bool isRefresh = false}) async {
    if (!isRefresh) {
      setState(() => _status = ReqState.loading);
    }
    try {
      final banners = await _repository.getPromoBanners();
      final categories = await _repository.getCategories();
      final products = await _repository.getCuratedArrivals();

      if (banners.isEmpty && categories.isEmpty && products.isEmpty) {
        if (mounted) setState(() => _status = ReqState.empty);
        return;
      }

      if (mounted) {
        setState(() {
          _banners = banners;
          _categories = categories;
          _products = products;
          _status = ReqState.success;
        });
      }
    } catch (e) {
      if (mounted && !isRefresh) {
        setState(() {
          _status = ReqState.failure;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _handleRefresh() async {
    await _loadHomeData(isRefresh: true);
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onFavoriteToggle(String productId) {
    setState(() {
      _products = _products.map((product) {
        if (product.id == productId) {
          return product.copyWith(isFavorite: !product.isFavorite);
        }
        return product;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReqStateWidget(
      state: _status,
      errorMessage: _errorMessage,
      onRetry: _loadHomeData,
      onLoading: (_) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
        ),
      ),
      onFailure: (context, error) => AppErrorWidget(
        message: error ?? 'Failed to load curated pieces',
        onRetry: _loadHomeData,
      ),
      onEmpty: (context) => Center(
        child: Text(
          'No pieces currently available in the atelier',
          style: TextStyle(fontSize: 14.sp, color: context.textSecondaryColor),
        ),
      ),
      onSuccess: (context) => CustomizedSmartRefresh(
        controller: _refreshController,
        onRefresh: _handleRefresh,
        enableRefresh: true,
        enableLoading: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // Header (Dokkan Atelier + Alexander greeting)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              sliver: const SliverToBoxAdapter(
                child: HomeHeader(userName: 'Alexander'),
              ),
            ),

            // Hero Banner (Season Atelier Leather promo carousel)
            SliverToBoxAdapter(
              child: HomePromoBanner(
                banners: _banners,
                activeIndex: _activeBannerIndex,
                onPageChanged: (index) {
                  setState(() => _activeBannerIndex = index);
                },
              ),
            ),

            // Collections category filter pills (scrolls edge-to-edge)
            SliverPadding(
              padding: EdgeInsets.only(top: 22.h),
              sliver: SliverToBoxAdapter(
                child: CollectionsSection(
                  categories: _categories,
                  selectedCategoryId: '',
                  onCategorySelected: (model) {
                    context.pushNamed(
                      Routes.productsByCategory,
                      arguments: model.name,
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
                  products: _products,
                  onProductTap: (product) {
                    context.pushNamed(
                      Routes.productDetails,
                      arguments: product,
                    );
                  },
                  onFavoriteToggle: _onFavoriteToggle,
                  onAddToCart: (product) {
                    CustomSnackBar.showSuccess(
                      context,
                      '${product.name} added to cart',
                    );
                  },
                ),
              ),
            ),

            // Bottom spacing sliver
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),
          ],
        ),
      ),
    );
  }
}
