import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/progress/checkout_progress_bar.dart';
import '../data/models/address_model.dart';
import '../data/models/payment_method_model.dart';
import 'widgets/checkout_app_bar.dart';
import 'widgets/checkout_bottom_bar.dart';
import 'widgets/delete_address_dialog.dart';
import 'widgets/step_order_summary.dart';
import 'widgets/step_payment_method.dart';
import 'widgets/step_select_address.dart';

class CheckoutScreen extends StatefulWidget {
  final int initialStep;

  const CheckoutScreen({
    super.key,
    this.initialStep = 0,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  late int _currentStep;
  ReqState _addressStatus = ReqState.success;
  late List<AddressModel> _addresses;
  String? _selectedAddressId;

  late List<PaymentMethodModel> _paymentMethods;
  late String _selectedPaymentMethodId;

  bool _isPlacingOrder = false;

  final List<Map<String, dynamic>> _mockOrderItems = [
    {
      'name': 'Heritage Chronograph Steel',
      'spec': '1x • Espresso Leather',
      'price': 149.00,
      'emoji': '⌚',
    },
    {
      'name': 'Italian Saffiano Tote',
      'spec': '1x • Cognac Brown',
      'price': 240.00,
      'emoji': '👜',
    },
    {
      'name': 'Bespoke Gold Signet Ring',
      'spec': '1x • 18k Solid Gold',
      'price': 185.00,
      'emoji': '💍',
    },
  ];

  double get _subtotal => _mockOrderItems.fold(
        0.0,
        (sum, item) => sum + (item['price'] as double),
      );

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep;
    _addresses = AddressModel.mockAddresses();
    if (_addresses.isNotEmpty) {
      _selectedAddressId = _addresses.first.id;
    }

    _paymentMethods = PaymentMethodModel.mockMethods();
    _selectedPaymentMethodId = _paymentMethods.first.id;
  }

  void _handleBack() {
    if (_currentStep > 0) {
      _carouselController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.pop();
    }
  }

  void _handleGoToStep(int step) {
    _carouselController.animateToPage(
      step,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  void _handleContinue() {
    if (_currentStep == 0) {
      if (_selectedAddressId == null) {
        CustomSnackBar.showError(context, 'Please select a delivery address');
        return;
      }
      _carouselController.animateToPage(
        1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else if (_currentStep == 1) {
      _carouselController.animateToPage(
        2,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _handleAddNewAddress() async {
    final newAddress = await context.pushNamed(Routes.checkoutAddEditAddress);
    if (newAddress is AddressModel && mounted) {
      setState(() {
        _addresses.add(newAddress);
        _selectedAddressId = newAddress.id;
      });
      CustomSnackBar.showSuccess(context, 'Delivery address added');
    }
  }

  Future<void> _handleEditAddress(AddressModel address) async {
    final updatedAddress = await context.pushNamed(
      Routes.checkoutAddEditAddress,
      arguments: address,
    );
    if (updatedAddress is AddressModel && mounted) {
      final index = _addresses.indexWhere((a) => a.id == updatedAddress.id);
      if (index != -1) {
        setState(() {
          _addresses[index] = updatedAddress;
        });
        CustomSnackBar.showSuccess(context, 'Delivery address updated');
      }
    }
  }

  Future<void> _handleDeleteAddress(AddressModel address) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => DeleteAddressDialog(
        street: address.street,
        city: address.city,
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _addresses.removeWhere((a) => a.id == address.id);
        if (_selectedAddressId == address.id) {
          _selectedAddressId = _addresses.isNotEmpty ? _addresses.first.id : null;
        }
      });
      CustomSnackBar.showSuccess(context, 'Address deleted successfully');
    }
  }

  Future<void> _handlePlaceOrder() async {
    if (_isPlacingOrder) return;
    setState(() => _isPlacingOrder = true);

    await Future.delayed(const Duration(milliseconds: 900));

    if (mounted) {
      setState(() => _isPlacingOrder = false);

      final selectedMethod = _paymentMethods.firstWhere(
        (m) => m.id == _selectedPaymentMethodId,
      );

      context.pushNamed(
        Routes.checkoutPaymentRedirect,
        arguments: {
          'orderId': '#DOK-98421',
          'total': _subtotal,
          'paymentMethod': selectedMethod.title,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedAddress = _addresses.firstWhere(
      (a) => a.id == _selectedAddressId,
      orElse: () => _addresses.isNotEmpty
          ? _addresses.first
          : AddressModel.mockAddresses().first,
    );

    final selectedPaymentMethod = _paymentMethods.firstWhere(
      (m) => m.id == _selectedPaymentMethodId,
      orElse: () => _paymentMethods.first,
    );

    return PopScope(
      canPop: _currentStep == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _handleBack();
        }
      },
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: CheckoutAppBar(
          currentStep: _currentStep,
          onBack: _handleBack,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Top Progress Bar synchronized with Carousel
              CheckoutProgressBar(currentStep: _currentStep + 1)
                  .animate()
                  .fadeIn(duration: 350.ms),

              // Carousel Slider hosting the 3 steps
              Expanded(
                child: CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    initialPage: _currentStep,
                    enableInfiniteScroll: false,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index, _) {
                      setState(() => _currentStep = index);
                    },
                  ),
                  items: [
                    // Step 0: Address
                    StepSelectAddress(
                      status: _addressStatus,
                      addresses: _addresses,
                      selectedAddressId: _selectedAddressId,
                      onSelectAddress: (id) =>
                          setState(() => _selectedAddressId = id),
                      onEditAddress: _handleEditAddress,
                      onDeleteAddress: _handleDeleteAddress,
                      onAddNewAddress: _handleAddNewAddress,
                      onRetry: () =>
                          setState(() => _addressStatus = ReqState.success),
                    ),

                    // Step 1: Payment Method
                    StepPaymentMethod(
                      methods: _paymentMethods,
                      selectedMethodId: _selectedPaymentMethodId,
                      onSelectMethod: (id) =>
                          setState(() => _selectedPaymentMethodId = id),
                    ),

                    // Step 2: Order Review
                    StepOrderSummary(
                      address: selectedAddress,
                      paymentMethod: selectedPaymentMethod,
                      items: _mockOrderItems,
                      subtotal: _subtotal,
                      onChangeAddress: () => _handleGoToStep(0),
                      onChangePayment: () => _handleGoToStep(1),
                    ),
                  ],
                ),
              ),

              // Unified Fixed Bottom Action Bar
              CheckoutBottomBar(
                currentStep: _currentStep,
                total: _subtotal,
                isPlacingOrder: _isPlacingOrder,
                onContinue: _handleContinue,
                onPlaceOrder: _handlePlaceOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

