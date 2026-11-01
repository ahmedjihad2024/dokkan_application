import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/address_model.dart';
import '../../data/models/payment_method_model.dart';
import 'order_address_summary_card.dart';
import 'order_items_preview_card.dart';
import 'order_payment_summary_card.dart';
import 'order_price_breakdown_card.dart';

class StepOrderSummary extends StatelessWidget {
  final AddressModel address;
  final PaymentMethodModel paymentMethod;
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final VoidCallback onChangeAddress;
  final VoidCallback onChangePayment;

  const StepOrderSummary({
    super.key,
    required this.address,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.onChangeAddress,
    required this.onChangePayment,
  });

  @override
  Widget build(BuildContext context) {
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

        // 3. Order Items Preview
        OrderItemsPreviewCard(items: items),
        12.verticalSpace,

        // 4. Price Breakdown
        OrderPriceBreakdownCard(
          itemCount: items.length,
          subtotal: subtotal,
        ),
        24.verticalSpace,
      ],
    );
  }
}

