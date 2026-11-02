import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/shared/domain/model/product_entity.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import 'widgets/products_by_category_grid.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String? categoryTitle;
  final List<ProductEntity>? initialProducts;

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

  late List<ProductEntity> _products;

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
    final title = widget.categoryTitle ?? 'Products';

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
      body: ReqStateWidget(
        state: ReqState.success,
        errorMessage: 'Failed to load products',
        onRetry: _handleRefresh,
        onSuccess: (context) => CustomizedSmartRefresh(
          controller: _refreshController,
          enableRefresh: true,
          enableLoading: true,
          onRefresh: _handleRefresh,
          onLoading: _handleLoadMore,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeM.pagePadding.w,
                  vertical: 16.h,
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
            ],
          ),
        ),
      ),
    );
  }

  static List<ProductEntity> _getDefaultProducts() {
    return const [
      ProductEntity(
        id: 'watch_1',
        name: 'Heritage Chronograph',
        price: 450.00,
        stock: 10,
        rating: 4.9,
        reviewsCount: 84,
        discountPercentage: 15,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_2',
        name: 'Milanese Gold Mesh',
        price: 210.00,
        stock: 15,
        rating: 4.9,
        reviewsCount: 42,
        discountPercentage: 12,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_3',
        name: 'Royal Skeleton Automatic',
        price: 750.00,
        stock: 6,
        rating: 5.0,
        reviewsCount: 88,
        discountPercentage: 17,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_4',
        name: 'Classic Bauhaus Minimalist',
        price: 165.00,
        stock: 20,
        rating: 4.8,
        reviewsCount: 34,
        discountPercentage: 0,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_5',
        name: 'Submariner Ceramic Diver',
        price: 550.00,
        stock: 8,
        rating: 4.9,
        reviewsCount: 112,
        discountPercentage: 10,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1539185441755-769473a23570?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_6',
        name: 'Grand Tourbillon Artisan',
        price: 1100.00,
        stock: 3,
        rating: 5.0,
        reviewsCount: 29,
        discountPercentage: 20,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1542496658-e33a6d0d50f6?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_7',
        name: 'Vintage Flieger 42mm',
        price: 295.00,
        stock: 12,
        rating: 4.7,
        reviewsCount: 51,
        discountPercentage: 0,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_8',
        name: 'Moonphase Rose Gold',
        price: 620.00,
        stock: 5,
        rating: 4.9,
        reviewsCount: 67,
        discountPercentage: 13,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1524592094714-0f0654e20314?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
      ProductEntity(
        id: 'watch_9',
        name: 'Monaco Racing Chronograph',
        price: 390.00,
        stock: 9,
        rating: 4.8,
        reviewsCount: 39,
        discountPercentage: 0,
        coverPictureUrl:
            'https://images.unsplash.com/photo-1533139502658-0198f920d8e8?auto=format&fit=crop&w=600&q=80',
        categories: ['watches'],
      ),
    ];
  }
}
