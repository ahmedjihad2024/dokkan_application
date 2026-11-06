import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../core/widgets/progress/checkout_progress_bar.dart';
import '../data/models/payment_method_model.dart';
import '../domain/model/address_entity.dart';
import 'cubit/checkout_cubit.dart';
import 'cubit/checkout_state.dart';
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
  late List<PaymentMethodModel> _paymentMethods;
  late String _selectedPaymentMethodId;
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep;
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

  void _handleContinue(CheckoutState state) {
    if (_currentStep == 0) {
      if (state.selectedAddressId == null) {
        CustomSnackBar.showError(context, 'Please select a delivery address');
        return;
      }
      _carouselController.animateToPage(
        1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else if (_currentStep == 1) {
      if (!state.isCartSuccess) {
        context.read<CheckoutCubit>().getCart();
      }
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
      context.read<CheckoutCubit>().addAddressLocally(newAddress);
      CustomSnackBar.showSuccess(context, 'Delivery address added');
    }
  }

  Future<void> _handleEditAddress(AddressModel address) async {
    final updatedAddress = await context.pushNamed(
      Routes.checkoutAddEditAddress,
      arguments: address,
    );
    if (updatedAddress is AddressModel && mounted) {
      context.read<CheckoutCubit>().editAddressLocally(updatedAddress);
      CustomSnackBar.showSuccess(context, 'Delivery address updated');
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
      await context.read<CheckoutCubit>().deleteAddress(
        address.id,
        context: context,
      );
    }
  }

  Future<void> _handlePlaceOrder(CheckoutState state) async {
    if (_isPlacingOrder || !state.canPlaceOrder) return;
    setState(() => _isPlacingOrder = true);

    await Future.delayed(const Duration(milliseconds: 900));

    if (mounted) {
      setState(() => _isPlacingOrder = false);

      final selectedMethod = _paymentMethods.firstWhere(
        (m) => m.id == _selectedPaymentMethodId,
        orElse: () => _paymentMethods.first,
      );

      context.pushNamed(
        Routes.checkoutPaymentRedirect,
        arguments: {
          'orderId': '#DOK-98421',
          'total': state.cartTotal,
          'paymentMethod': selectedMethod.title,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final selectedAddress = state.selectedAddress ??
            (state.addresses.isNotEmpty
                ? state.addresses.first
                : AddressModel.mockAddresses().first);

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
                          status: state.addressStatus,
                          errorMessage: state.errorMessage,
                          addresses: state.addresses,
                          selectedAddressId: state.selectedAddressId,
                          deletingAddressId: state.deletingAddressId,
                          onSelectAddress: (id) =>
                              context.read<CheckoutCubit>().selectAddress(id),
                          onEditAddress: _handleEditAddress,
                          onDeleteAddress: _handleDeleteAddress,
                          onAddNewAddress: _handleAddNewAddress,
                          onRetry: () =>
                              context.read<CheckoutCubit>().getAddresses(),
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
                          cartStatus: state.cartStatus,
                          cartItems: state.cartItems,
                          subtotal: state.cartTotal,
                          cartErrorMessage: state.cartErrorMessage,
                          onRetryCart: () =>
                              context.read<CheckoutCubit>().getCart(),
                          onChangeAddress: () => _handleGoToStep(0),
                          onChangePayment: () => _handleGoToStep(1),
                        ),
                      ],
                    ),
                  ),

                  // Unified Fixed Bottom Action Bar
                  CheckoutBottomBar(
                    currentStep: _currentStep,
                    total: state.cartTotal,
                    isPlacingOrder: _isPlacingOrder,
                    isCartLoading: state.isCartLoading,
                    isPlaceOrderEnabled: state.canPlaceOrder,
                    onContinue: () => _handleContinue(state),
                    onPlaceOrder: () => _handlePlaceOrder(state),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
