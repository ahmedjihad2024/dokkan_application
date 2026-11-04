import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/request_state.dart';
import '../../../cart/domain/model/cart_entity.dart';
import '../../data/models/payment_method_model.dart';
import '../../domain/model/address_entity.dart';
import 'order_address_summary_card.dart';
import 'order_cart_error_card.dart';
import 'order_items_preview_card.dart';
import 'order_payment_summary_card.dart';
import 'order_price_breakdown_card.dart';

class StepOrderSummary extends StatelessWidget {
  final AddressModel address;
  final PaymentMethodModel paymentMethod;
  final ReqState cartStatus;
  final List<CartItemEntity> cartItems;
  final double subtotal;
  final String? cartErrorMessage;
  final VoidCallback onRetryCart;
  final VoidCallback onChangeAddress;
  final VoidCallback onChangePayment;

  const StepOrderSummary({
    super.key,
    required this.address,
    required this.paymentMethod,
    required this.cartStatus,
    required this.cartItems,
    required this.subtotal,
    this.cartErrorMessage,
    required this.onRetryCart,
    required this.onChangeAddress,
    required this.onChangePayment,
  });

  @override
  Widget build(BuildContext context) {
    final isCartLoading = cartStatus == ReqState.loading;
    final isCartFailure = cartStatus == ReqState.failure;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      children: [
        // 1. Delivery Address Card
        OrderAddressSummaryCard(
          address: address,
          onChange: onChangeAddress,
        ),
        12.verticalSpace,

        // 2. Payment Method Card
        OrderPaymentSummaryCard(
          paymentMethod: paymentMethod,
          onChange: onChangePayment,
        ),
        12.verticalSpace,

        // 3. Cart Error State OR (Order Items + Price Breakdown)
        if (isCartFailure) ...[
          OrderCartErrorCard(
            errorMessage: cartErrorMessage,
            onRetry: onRetryCart,
          ),
          24.verticalSpace,
        ] else ...[
          // Order Items Preview (real or shimmer)
          OrderItemsPreviewCard(
            items: cartItems,
            isLoading: isCartLoading,
          ),
          12.verticalSpace,

          // Price Breakdown (real or shimmer)
          OrderPriceBreakdownCard(
            itemCount: cartItems.length,
            subtotal: subtotal,
            isLoading: isCartLoading,
          ),
          24.verticalSpace,
        ],
      ],
    );
  }
}
