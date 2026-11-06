import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/fonts_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../main_layout/presentation/cubit/layout_cubit.dart';
import 'cubit/cart_cubit.dart';
import 'cubit/cart_state.dart';
import 'widgets/cart_error_view.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/cart_order_summary.dart';
import 'widgets/cart_shimmer_loading.dart';
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

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await context.read<CartCubit>().refreshCart();
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onExploreCollections() {
    try {
      context.read<LayoutCubit>().setNavIndex(0);
    } catch (_) {}
  }

  void _handleCheckout() {
    context.pushNamed(Routes.checkoutSelectAddress);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: BlocConsumer<CartCubit, CartState>(
        listenWhen: (previous, current) => current is CartActionFailed,
        listener: (context, state) {
          if (state is CartActionFailed) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        buildWhen: (previous, current) => current is! CartActionFailed,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, state),
              Expanded(child: _buildContent(context, state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CartState state) {
    final active = state is CartActive ? state : null;

    return Padding(
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
                if (active != null) ...[
                  2.verticalSpace,
                  Text(
                    '${active.cart.totalItemCount} item${active.cart.totalItemCount == 1 ? '' : 's'}',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (active != null)
            InkWell(
              onTap: active.isUpdating
                  ? null
                  : () => context.read<CartCubit>().clearCart(),
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
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, CartState state) {
    if (state is CartLoading) {
      return const CartShimmerLoading();
    }

    if (state is CartError) {
      return CartErrorView(
        message: state.message,
        onRetry: () => context.read<CartCubit>().loadCart(),
      );
    }

    return CustomizedSmartRefresh(
      controller: _refreshController,
      onRefresh: _handleRefresh,
      enableRefresh: true,
      enableLoading: false,
      child: state is CartActive
          ? _buildList(context, state)
          : _buildEmpty(),
    );
  }

  Widget _buildEmpty() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: 480.h,
        child: EmptyCartView(onExplore: _onExploreCollections),
      ),
    );
  }

  Widget _buildList(BuildContext context, CartActive state) {
    final cubit = context.read<CartCubit>();
    final items = state.cart.items;
    final busy = state.isUpdating;

    return ListView.builder(
      padding: EdgeInsets.only(
        left: SizeM.pagePaddingLarge.w,
        right: SizeM.pagePaddingLarge.w,
        bottom: 24.h,
      ),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: CartOrderSummary(
              totalCount: state.cart.totalItemCount,
              subtotal: state.cart.totalCartPrice,
              onCheckout: _handleCheckout,
            ),
          );
        }

        final item = items[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CartItemCard(
            item: item,
            onIncrement: (busy || !item.canIncrement)
                ? null
                : () => cubit.increment(item),
            onDecrement: busy ? null : () => cubit.decrement(item),
            onRemove: busy ? null : () => cubit.remove(item),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
