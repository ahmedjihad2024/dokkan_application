import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/fonts_manager.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../main_layout/presentation/cubit/layout_cubit.dart';
import '../data/models/cart_item_model.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/cart_order_summary.dart';
import 'widgets/empty_cart_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  late List<CartItemModel> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      const CartItemModel(
        id: 'cart_1',
        name: 'Heritage Chronograph Steel',
        variant: 'Espresso Leather • 42mm',
        price: 149.00,
        quantity: 1,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=600&q=80',
      ),
      const CartItemModel(
        id: 'cart_2',
        name: 'Italian Saffiano Tote',
        variant: 'Cognac Brown • Calfskin',
        price: 240.00,
        quantity: 1,
        emoji: '👜',
        imageUrl:
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
      ),
      const CartItemModel(
        id: 'cart_3',
        name: 'Bespoke Gold Signet Ring',
        variant: '18k Solid Gold • Size 9',
        price: 185.00,
        quantity: 1,
        emoji: '💍',
        imageUrl:
            'https://images.unsplash.com/photo-1605100804763-247f67b3557e?auto=format&fit=crop&w=600&q=80',
      ),
    ];
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

  double get _subtotal {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get _totalCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  void _increment(int index) {
    setState(() {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    });
  }

  void _decrement(int index) {
    setState(() {
      if (_items[index].quantity <= 1) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(
          quantity: _items[index].quantity - 1,
        );
      }
    });
  }

  void _remove(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _clearBag() {
    setState(() {
      _items.clear();
    });
  }

  void _onExploreCollections() {
    try {
      context.read<LayoutCubit>().setNavIndex(0);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isEmpty = _items.isEmpty;

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Header (Figma: H:56, Padding: 24px)
          Padding(
            padding: EdgeInsets.fromLTRB(
              SizeM.pagePaddingLarge.w,
              18.h,
              SizeM.pagePaddingLarge.w,
              14.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Shopping Bag',
                        style: TextStyle(
                          color: context.textPrimaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeightM.bold,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: -0.06, end: 0, curve: Curves.easeOutCubic),
                      if (!isEmpty) ...[
                        Gap(2.h),
                        Text(
                          '$_totalCount handcrafted item${_totalCount == 1 ? '' : 's'}',
                          style: TextStyle(
                            color: context.textSecondaryColor,
                            fontSize: 12.sp,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 400.ms, delay: 60.ms),
                      ],
                    ],
                  ),
                ),
                if (!isEmpty)
                  InkWell(
                    onTap: _clearBag,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.dangerContainerColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Clear Bag',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeightM.semiBold,
                          color: ColorM.danger,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 350.ms, delay: 80.ms),
              ],
            ),
          ),

          // Content with CustomizedSmartRefresh
          Expanded(
            child: CustomizedSmartRefresh(
              controller: _refreshController,
              onRefresh: _handleRefresh,
              enableRefresh: true,
              enableLoading: false,
              child: isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: 480.h,
                        child: EmptyCartView(onExplore: _onExploreCollections),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(
                        left: SizeM.pagePaddingLarge.w,
                        right: SizeM.pagePaddingLarge.w,
                        bottom: 24.h,
                      ),
                      itemCount: _items.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _items.length) {
                          // Order Summary Card
                          return Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: CartOrderSummary(
                              totalCount: _totalCount,
                              subtotal: _subtotal,
                            )
                                .animate(
                                  delay: (100 + (_items.length * 70)).ms,
                                )
                                .fadeIn(
                                  duration: 450.ms,
                                  curve: Curves.easeOutCubic,
                                )
                                .slideY(
                                  begin: 0.1,
                                  end: 0,
                                  duration: 450.ms,
                                  curve: Curves.easeOutCubic,
                                ),
                          );
                        }

                        // Cart Item Card with staggered entrance
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: CartItemCard(
                            item: _items[index],
                            onIncrement: () => _increment(index),
                            onDecrement: () => _decrement(index),
                            onRemove: () => _remove(index),
                          )
                              .animate(delay: (80 + (index * 70)).ms)
                              .fadeIn(
                                duration: 420.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .slideY(
                                begin: 0.1,
                                end: 0,
                                duration: 420.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .scale(
                                begin: const Offset(0.97, 0.97),
                                end: const Offset(1, 1),
                                duration: 420.ms,
                                curve: Curves.easeOutCubic,
                              ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
