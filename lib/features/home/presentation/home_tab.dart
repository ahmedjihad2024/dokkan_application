import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/res/gen/assets.gen.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../data/models/category_model.dart';
import '../data/models/product_model.dart';
import '../data/models/promo_banner_model.dart';
import 'widgets/collections_section.dart';
import 'widgets/curated_arrivals_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_promo_banner.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  late List<PromoBannerModel> _banners;
  late List<CategoryModel> _categories;
  late List<ProductModel> _products;
  int _activeBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _banners = _getMockBanners();
    _categories = _getMockCategories();
    _products = _getMockProducts();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 600));
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
    super.build(context);
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
    );
  }

  static List<PromoBannerModel> _getMockBanners() {
    return [
      PromoBannerModel(
        id: 'banner_1',
        badgeText: 'SEASON ATELIER',
        title: 'Italian Saffiano Leather',
        subtitle: 'Up to 40% off bespoke travel bags & wallets',
        visualEmoji: '👜',
        imageAsset: Assets.images.bannerBag.path,
      ),
      PromoBannerModel(
        id: 'banner_2',
        badgeText: 'LIMITED EDITION',
        title: 'Bespoke Chronographs',
        subtitle: 'Swiss-movement artisan timepieces for connoisseurs',
        visualEmoji: '⌚',
        imageAsset: Assets.images.bannerWatch.path,
      ),
      PromoBannerModel(
        id: 'banner_3',
        badgeText: 'ATELIER EXCLUSIVE',
        title: 'Handcrafted Heritage',
        subtitle: 'Custom silver & 18k gold handcrafted jewelry',
        visualEmoji: '💍',
        imageAsset: Assets.images.bannerRing.path,
      ),
    ];
  }

  static List<CategoryModel> _getMockCategories() {
    return const [
      CategoryModel(id: 'all', name: 'All Items'),
      CategoryModel(id: 'watches', name: 'Watches'),
      CategoryModel(id: 'bags', name: 'Bags'),
      CategoryModel(id: 'eyewear', name: 'Eyewear'),
      CategoryModel(id: 'jewelry', name: 'Jewelry'),
      CategoryModel(id: 'wallets', name: 'Wallets'),
    ];
  }

  static List<ProductModel> _getMockProducts() {
    return const [
      ProductModel(
        id: 'prod_1',
        name: 'Chronograph Watch',
        categoryId: 'watches',
        currentPrice: 149.00,
        originalPrice: 199.00,
        rating: 4.9,
        reviewsCount: 84,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=600&q=80',
        discountTag: '-25%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'prod_2',
        name: 'Saffiano Tote Bag',
        categoryId: 'bags',
        currentPrice: 240.00,
        originalPrice: 280.00,
        rating: 4.8,
        reviewsCount: 62,
        emoji: '👜',
        imageUrl:
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
        discountTag: '-15%',
        isFavorite: true,
      ),
      ProductModel(
        id: 'prod_3',
        name: 'Classic Aviator',
        categoryId: 'eyewear',
        currentPrice: 110.00,
        originalPrice: 135.00,
        rating: 4.7,
        reviewsCount: 45,
        emoji: '🕶️',
        imageUrl:
            'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=600&q=80',
        discountTag: '-18%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'prod_4',
        name: 'Signet Gold Ring',
        categoryId: 'jewelry',
        currentPrice: 185.00,
        originalPrice: 220.00,
        rating: 4.9,
        reviewsCount: 112,
        emoji: '💍',
        imageUrl:
            'https://images.unsplash.com/photo-1605100804763-247f67b3557e?auto=format&fit=crop&w=600&q=80',
        discountTag: '-15%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'prod_5',
        name: 'Heritage Slim Wallet',
        categoryId: 'wallets',
        currentPrice: 85.00,
        originalPrice: 105.00,
        rating: 4.9,
        reviewsCount: 98,
        emoji: '👛',
        imageUrl:
            'https://images.unsplash.com/photo-1627123424574-724758594e93?auto=format&fit=crop&w=600&q=80',
        discountTag: '-20%',
        isFavorite: false,
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
