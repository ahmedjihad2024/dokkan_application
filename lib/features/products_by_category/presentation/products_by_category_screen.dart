import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import '../../home/data/models/product_model.dart';
import 'widgets/products_by_category_grid.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String? categoryTitle;
  final List<ProductModel>? initialProducts;

  const ProductsByCategoryScreen({
    super.key,
    this.categoryTitle,
    this.initialProducts,
  });

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  late List<ProductModel> _products;

  @override
  void initState() {
    super.initState();
    _products = widget.initialProducts ?? _getDefaultProducts();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> _handleLoadMore() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.categoryTitle ?? 'Luxury Timepieces';

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.surfaceColor,
              shape: const CircleBorder(),
            ),
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: Text(title),
      ),
      body: ReqStateWidget(
        state: ReqState.success,
        errorMessage: '',
        onRetry: () {},
        onLoading: (_) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
          ),
        ),
        onFailure: (context, error) => AppErrorWidget(
          message: error ?? '',
          onRetry: () {},
        ),
        onEmpty: (context) => Center(
          child: Text(
            'No pieces currently available in this category',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.textSecondaryColor,
            ),
          ),
        ),
        onSuccess: (context) => CustomizedSmartRefresh(
          controller: _refreshController,
          onRefresh: _handleRefresh,
          onLoading: _handleLoadMore,
          enableRefresh: true,
          enableLoading: true,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Subtitle — verified models count
              SliverPadding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  left: SizeM.pagePaddingLarge.w,
                  right: SizeM.pagePaddingLarge.w,
                  bottom: 14.h,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    '${_products.length} verified models in stock',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 13.sp,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        curve: Curves.easeOutCubic,
                      ),
                ),
              ),

              // Products grid with animated cards
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeM.pagePaddingLarge.w,
                ),
                sliver: ProductsByCategoryGrid(
                  products: _products,
                  onProductTap: (product) {
                    context.pushNamed(
                      Routes.productDetails,
                      arguments: product,
                    );
                  },
                ),
              ),

              // Bottom padding sliver
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<ProductModel> _getDefaultProducts() {
    return const [
      ProductModel(
        id: 'watch_1',
        name: 'Heritage Chronograph',
        categoryId: 'watches',
        currentPrice: 385.00,
        originalPrice: 450.00,
        rating: 4.9,
        reviewsCount: 84,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=600&q=80',
        discountTag: '-15%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'watch_2',
        name: 'Milanese Gold Mesh',
        categoryId: 'watches',
        currentPrice: 185.00,
        originalPrice: 210.00,
        rating: 4.9,
        reviewsCount: 42,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
        discountTag: '-12%',
        isFavorite: true,
      ),
      ProductModel(
        id: 'watch_3',
        name: 'Royal Skeleton Automatic',
        categoryId: 'watches',
        currentPrice: 620.00,
        originalPrice: 750.00,
        rating: 5.0,
        reviewsCount: 88,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=600&q=80',
        discountTag: '-17%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'watch_4',
        name: 'Classic Bauhaus Minimalist',
        categoryId: 'watches',
        currentPrice: 145.00,
        originalPrice: 165.00,
        rating: 4.8,
        reviewsCount: 34,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=600&q=80',
        isFavorite: false,
      ),
      ProductModel(
        id: 'watch_5',
        name: 'Submariner Ceramic Diver',
        categoryId: 'watches',
        currentPrice: 495.00,
        originalPrice: 550.00,
        rating: 4.9,
        reviewsCount: 112,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1539185441755-769473a23570?auto=format&fit=crop&w=600&q=80',
        discountTag: '-10%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'watch_6',
        name: 'Grand Tourbillon Artisan',
        categoryId: 'watches',
        currentPrice: 890.00,
        originalPrice: 1100.00,
        rating: 5.0,
        reviewsCount: 29,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1542496658-e33a6d0d50f6?auto=format&fit=crop&w=600&q=80',
        discountTag: '-20%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'watch_7',
        name: 'Vintage Flieger 42mm',
        categoryId: 'watches',
        currentPrice: 265.00,
        originalPrice: 295.00,
        rating: 4.7,
        reviewsCount: 51,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?auto=format&fit=crop&w=600&q=80',
        isFavorite: false,
      ),
      ProductModel(
        id: 'watch_8',
        name: 'Moonphase Rose Gold',
        categoryId: 'watches',
        currentPrice: 540.00,
        originalPrice: 620.00,
        rating: 4.9,
        reviewsCount: 67,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1524592094714-0f0654e20314?auto=format&fit=crop&w=600&q=80',
        discountTag: '-13%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'watch_9',
        name: 'Monaco Racing Chronograph',
        categoryId: 'watches',
        currentPrice: 340.00,
        originalPrice: 390.00,
        rating: 4.8,
        reviewsCount: 39,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1533139502658-0198f920d8e8?auto=format&fit=crop&w=600&q=80',
        isFavorite: false,
      ),
    ];
  }
}
