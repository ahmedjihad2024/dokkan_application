import '../../../../core/enums/request_state.dart';
import '../../../cart/domain/model/cart_entity.dart';
import '../../domain/model/address_entity.dart';

class CheckoutState {
  // Address fields
  final ReqState addressStatus;
  final List<AddressEntity> addresses;
  final String? selectedAddressId;
  final String? deletingAddressId;
  final String? errorMessage;

  // Cart fields
  final ReqState cartStatus;
  final CartEntity? cart;
  final String? cartErrorMessage;

  const CheckoutState({
    this.addressStatus = ReqState.loading,
    this.addresses = const [],
    this.selectedAddressId,
    this.deletingAddressId,
    this.errorMessage,
    this.cartStatus = ReqState.idle,
    this.cart,
    this.cartErrorMessage,
  });

  const CheckoutState.initial()
      : addressStatus = ReqState.loading,
        addresses = const [],
        selectedAddressId = null,
        deletingAddressId = null,
        errorMessage = null,
        cartStatus = ReqState.idle,
        cart = null,
        cartErrorMessage = null;

  const CheckoutState.loading({
    this.addresses = const [],
    this.selectedAddressId,
    this.cartStatus = ReqState.idle,
    this.cart,
    this.cartErrorMessage,
  })  : addressStatus = ReqState.loading,
        deletingAddressId = null,
        errorMessage = null;

  const CheckoutState.success({
    required this.addresses,
    this.selectedAddressId,
    this.cartStatus = ReqState.idle,
    this.cart,
    this.cartErrorMessage,
  })  : addressStatus = ReqState.success,
        deletingAddressId = null,
        errorMessage = null;

  const CheckoutState.error({
    required this.errorMessage,
    this.addresses = const [],
    this.selectedAddressId,
    this.cartStatus = ReqState.idle,
    this.cart,
    this.cartErrorMessage,
  })  : addressStatus = ReqState.failure,
        deletingAddressId = null;

  const CheckoutState.deleting({
    required this.addresses,
    required this.deletingAddressId,
    this.selectedAddressId,
    this.cartStatus = ReqState.idle,
    this.cart,
    this.cartErrorMessage,
  })  : addressStatus = ReqState.success,
        errorMessage = null;

  bool isDeleting(String id) => deletingAddressId == id;
  bool get isDeletingAddress => deletingAddressId != null;

  AddressEntity? get selectedAddress {
    if (addresses.isEmpty) return null;
    return addresses.where((a) => a.id == selectedAddressId).firstOrNull ??
        addresses.first;
  }

  // Cart convenience getters
  List<CartItemEntity> get cartItems => cart?.items ?? const [];
  double get cartTotal => cart?.totalCartPrice ?? 0.0;
  int get cartItemCount => cart?.totalItemCount ?? 0;
  bool get isCartLoading => cartStatus == ReqState.loading;
  bool get isCartSuccess => cartStatus == ReqState.success;
  bool get isCartFailure => cartStatus == ReqState.failure;
  bool get canPlaceOrder =>
      selectedAddressId != null &&
      cartStatus == ReqState.success &&
      (cart?.isNotEmpty ?? false) &&
      deletingAddressId == null;

  // State transitions preserving other slices
  CheckoutState asAddressLoading() => CheckoutState(
        addressStatus: ReqState.loading,
        addresses: addresses,
        selectedAddressId: selectedAddressId,
        deletingAddressId: null,
        errorMessage: null,
        cartStatus: cartStatus,
        cart: cart,
        cartErrorMessage: cartErrorMessage,
      );

  CheckoutState asAddressSuccess({
    required List<AddressEntity> addresses,
    String? selectedAddressId,
  }) =>
      CheckoutState(
        addressStatus: ReqState.success,
        addresses: addresses,
        selectedAddressId: selectedAddressId,
        deletingAddressId: null,
        errorMessage: null,
        cartStatus: cartStatus,
        cart: cart,
        cartErrorMessage: cartErrorMessage,
      );

  CheckoutState asAddressError(String message) => CheckoutState(
        addressStatus: ReqState.failure,
        addresses: addresses,
        selectedAddressId: selectedAddressId,
        deletingAddressId: null,
        errorMessage: message,
        cartStatus: cartStatus,
        cart: cart,
        cartErrorMessage: cartErrorMessage,
      );

  CheckoutState asAddressDeleting(String id) => CheckoutState(
        addressStatus: ReqState.success,
        addresses: addresses,
        selectedAddressId: selectedAddressId,
        deletingAddressId: id,
        errorMessage: null,
        cartStatus: cartStatus,
        cart: cart,
        cartErrorMessage: cartErrorMessage,
      );

  CheckoutState asCartLoading() => CheckoutState(
        addressStatus: addressStatus,
        addresses: addresses,
        selectedAddressId: selectedAddressId,
        deletingAddressId: deletingAddressId,
        errorMessage: errorMessage,
        cartStatus: ReqState.loading,
        cart: cart,
        cartErrorMessage: null,
      );

  CheckoutState asCartSuccess(CartEntity cart) => CheckoutState(
        addressStatus: addressStatus,
        addresses: addresses,
        selectedAddressId: selectedAddressId,
        deletingAddressId: deletingAddressId,
        errorMessage: errorMessage,
        cartStatus: ReqState.success,
        cart: cart,
        cartErrorMessage: null,
      );

  CheckoutState asCartError(String message) => CheckoutState(
        addressStatus: addressStatus,
        addresses: addresses,
        selectedAddressId: selectedAddressId,
        deletingAddressId: deletingAddressId,
        errorMessage: errorMessage,
        cartStatus: ReqState.failure,
        cart: cart,
        cartErrorMessage: message,
      );

  CheckoutState copyWith({
    ReqState? addressStatus,
    List<AddressEntity>? addresses,
    String? selectedAddressId,
    String? deletingAddressId,
    String? errorMessage,
    ReqState? cartStatus,
    CartEntity? cart,
    String? cartErrorMessage,
  }) {
    return CheckoutState(
      addressStatus: addressStatus ?? this.addressStatus,
      addresses: addresses ?? this.addresses,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      deletingAddressId: deletingAddressId ?? this.deletingAddressId,
      errorMessage: errorMessage ?? this.errorMessage,
      cartStatus: cartStatus ?? this.cartStatus,
      cart: cart ?? this.cart,
      cartErrorMessage: cartErrorMessage ?? this.cartErrorMessage,
    );
  }
}
