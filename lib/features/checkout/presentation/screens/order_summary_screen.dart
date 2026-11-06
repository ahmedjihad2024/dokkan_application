import 'package:flutter/material.dart';

import '../../domain/model/address_entity.dart';
import '../../data/models/payment_method_model.dart';
import '../checkout_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  final AddressModel? address;
  final PaymentMethodModel? paymentMethod;

  const OrderSummaryScreen({
    super.key,
    this.address,
    this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return const CheckoutScreen(initialStep: 2);
  }
}
