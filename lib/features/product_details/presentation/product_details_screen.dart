import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../home/data/models/product_model.dart';
import '../data/models/product_review_model.dart';
import 'widgets/product_bottom_bar.dart';
import 'widgets/product_details_app_bar.dart';
import 'widgets/product_image_gallery.dart';
import 'widgets/product_info_header.dart';
import 'widgets/product_reviews_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel? product;

  const ProductDetailsScreen({super.key, this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductModel _product;
  late bool _isFavorite;
  int _quantity = 1;
  final int _maxStock = 8;

  @override
  void initState() {
    super.initState();
    _product = widget.product ?? _createDefaultWatchProduct();
    _isFavorite = _product.isFavorite;
  }

  static ProductModel _createDefaultWatchProduct() {
    return const ProductModel(
      id: 'watch_dok_9842',
      name: 'Heritage Chronograph Steel Watch',
      categoryId: 'watches',
      currentPrice: 149.00,
      originalPrice: 199.00,
      rating: 4.9,
      reviewsCount: 128,
      emoji: '⌚',
      discountTag: '-25%',
      isFavorite: false,
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _product = _product.copyWith(isFavorite: _isFavorite);
    });
    CustomSnackBar.showSuccess(
      context,
      _isFavorite ? 'Saved to your Wishlist' : 'Removed from Wishlist',
    );
  }

  void _incrementQuantity() {
    if (_quantity < _maxStock) {
      setState(() => _quantity++);
    } else {
      CustomSnackBar.showWarning(context, 'Only $_maxStock left in stock');
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _handleAddToCart() {
    CustomSnackBar.showSuccess(
      context,
      'Added $_quantity x ${_product.name} to your bag',
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _product.currentPrice * _quantity;

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // App Bar matching Figma 37:509 / 37:569
            ProductDetailsAppBar(
              isFavorite: _isFavorite,
              onFavoriteToggle: _toggleFavorite,
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),

                    // Hero Image & Thumbnail selector matching Figma 37:515 - 37:525
                    ProductImageGallery(
                      imageUrl: _product.imageUrl,
                      discountTag: _product.discountTag ?? '-25%',
                      emoji: _product.emoji,
                    ),

                    SizedBox(height: 16.h),

                    // Title, Code, Price, Chips & Description matching Figma 37:526 - 37:540
                    ProductInfoHeader(
                      title: _product.name,
                      subtitle:
                          'Product Code: DOK-9842 • 2-Year Official Warranty',
                      currentPrice: _product.currentPrice,
                      originalPrice: _product.originalPrice ?? 199.00,
                      materialText: 'Espresso Leather',
                      weightText: 'Weight: 142g',
                      stockText: '● In Stock ($_maxStock left)',
                      description:
                          'Handcrafted Italian calfskin strap with 316L surgical steel and scratch-resistant sapphire crystal glass. 50m water resistant.',
                    ),

                    SizedBox(height: 20.h),

                    // Customer Reviews Section matching Figma 37:541 - 37:555
                    ProductReviewsSection(
                      productName: _product.name,
                      rating: _product.rating,
                      reviewsCount: _product.reviewsCount,
                      reviews: ProductReviewModel.defaultReviews(),
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Sticky Bottom Action Bar matching Figma 37:556 - 37:563
      bottomNavigationBar: ProductBottomBar(
        quantity: _quantity,
        totalPrice: totalPrice,
        onIncrement: _incrementQuantity,
        onDecrement: _decrementQuantity,
        onAddToCart: _handleAddToCart,
      ),
    );
  }
}
