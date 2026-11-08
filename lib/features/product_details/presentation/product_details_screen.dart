import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/widgets/feedback/app_error_widget.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import 'cubit/product_details_cubit.dart';
import 'cubit/product_details_state.dart';
import 'widgets/product_bottom_bar.dart';
import 'widgets/product_details_app_bar.dart';
import 'widgets/product_details_shimmer.dart';
import 'widgets/product_image_gallery.dart';
import 'widgets/product_info_header.dart';
import 'widgets/product_reviews_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailsCubit>().init(widget.productId);
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    CustomSnackBar.showSuccess(
      context,
      _isFavorite ? 'Saved to your Wishlist' : 'Removed from Wishlist',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Always-visible real App Bar so users can always navigate back (iOS & Android)
            ProductDetailsAppBar(
              isFavorite: _isFavorite,
              onFavoriteToggle: _toggleFavorite,
            ),

            // Main body area controlled by state
            Expanded(
              child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
                listener: (context, state) {
                  if (state is ProductDetailsError) {
                    CustomSnackBar.showError(context, state.message);
                  }
                },
                builder: (context, state) {
                  // 1. Loading State -> Skeletonizer shimmer for content body & bottom bar
                  if (state is ProductDetailsLoading ||
                      state is ProductDetailsInitial) {
                    return const ProductDetailsShimmer();
                  }

                  // 2. Error State -> AppErrorWidget with retry button
                  if (state is ProductDetailsError) {
                    return Center(
                      child: AppErrorWidget(
                        message: state.message,
                        onRetry: () {
                          context
                              .read<ProductDetailsCubit>()
                              .init(widget.productId);
                        },
                      ),
                    );
                  }

                  // 3. Success State -> Interactive UI with Domain Entity
                  if (state is ProductDetailsSuccess) {
                    final product = state.product;
                    final cubit = context.read<ProductDetailsCubit>();
                    final totalPrice = product.finalPrice * state.quantity;
                    final maxStock = product.stock > 0 ? product.stock : 1;

                    return Column(
                      children: [
                        // Scrollable Content using CustomScrollView & Slivers
                        Expanded(
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            slivers: [
                              // Hero image gallery with discount badge & thumbnail selector
                              SliverPadding(
                                padding: EdgeInsets.only(
                                  top: 4.h,
                                  left: 24.w,
                                  right: 24.w,
                                ),
                                sliver: SliverToBoxAdapter(
                                  child: ProductImageGallery(
                                    imageUrl: product.coverPictureUrl,
                                    pictures: product.productPictures,
                                    discountTag: product.hasDiscount
                                        ? '-${product.discountPercentage}%'
                                        : null,
                                    emoji: '✨',
                                  )
                                      .animate()
                                      .fadeIn(duration: 450.ms)
                                      .scale(
                                        begin: const Offset(0.96, 0.96),
                                        end: const Offset(1, 1),
                                        curve: Curves.easeOutCubic,
                                      ),
                                ),
                              ),

                              // Title, Code, Price, Chips & Description
                              SliverPadding(
                                padding: EdgeInsets.only(
                                  top: 16.h,
                                  left: 24.w,
                                  right: 24.w,
                                ),
                                sliver: SliverToBoxAdapter(
                                  child: ProductInfoHeader(
                                    title: product.name,
                                    subtitle:
                                        'Product Code: ${product.productCode ?? 'PRD-${product.id.length >= 6 ? product.id.substring(0, 6).toUpperCase() : product.id}'} • Official Warranty',
                                    currentPrice: product.finalPrice,
                                    originalPrice: product.price == product.finalPrice ? null : product.price,
                                    materialText: product.color ?? 'Gold',
                                    weightText: product.weight != null
                                        ? 'Weight: ${product.weight}g'
                                        : 'Weight: 60g',
                                    stockText: product.stock > 0
                                        ? '● In Stock (${product.stock} left)'
                                        : '● Out of Stock',
                                    description: product.description ??
                                        'Crafted with exquisite attention to detail.',
                                  )
                                      .animate()
                                      .fadeIn(duration: 400.ms, delay: 100.ms)
                                      .slideY(
                                        begin: 0.08,
                                        end: 0,
                                        curve: Curves.easeOutCubic,
                                      ),
                                ),
                              ),

                              // Customer Reviews Section (Hidden if empty)
                              if (state.reviews.isNotEmpty)
                                SliverPadding(
                                  padding: EdgeInsets.only(
                                    top: 20.h,
                                    left: 24.w,
                                    right: 24.w,
                                  ),
                                  sliver: SliverToBoxAdapter(
                                    child: ProductReviewsSection(
                                      productId: product.id,
                                      productName: product.name,
                                      rating: state.averageRating,
                                      reviewsCount: state.reviewsCount,
                                      reviews: state.reviews,
                                      onExploreAll: () {
                                        context.pushNamed(
                                          Routes.productReviews,
                                          arguments: {
                                            'productId': product.id,
                                            'productName': product.name,
                                            'rating': state.averageRating,
                                            'reviewsCount': state.reviewsCount,
                                          },
                                        );
                                      },
                                    )
                                        .animate()
                                        .fadeIn(duration: 400.ms, delay: 180.ms)
                                        .slideY(
                                          begin: 0.08,
                                          end: 0,
                                          curve: Curves.easeOutCubic,
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

                        // Sticky Bottom Action Bar matching Figma 37:556 - 37:563
                        ProductBottomBar(
                          quantity: state.quantity,
                          totalPrice: totalPrice,
                          isLoading: state.isAddingToCart,
                          onIncrement: () =>
                              cubit.incrementQuantity(maxStock, context),
                          onDecrement: () => cubit.decrementQuantity(),
                          onAddToCart: () => cubit.addToCart(
                            product.id,
                            state.quantity,
                            context,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 400.ms, delay: 120.ms)
                            .slideY(
                              begin: 0.12,
                              end: 0,
                              curve: Curves.easeOutCubic,
                            ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
