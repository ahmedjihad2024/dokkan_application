import '../../../../core/network/base_response.dart';

class CartItemActionResponse implements BasicResponse {
  final String? responseMessage;
  final String itemId;
  final String productId;
  final int quantity;
  final bool? isSuccess;

  const CartItemActionResponse({
    this.responseMessage,
    required this.itemId,
    required this.productId,
    required this.quantity,
    this.isSuccess,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Cart updated successfully' : 'Failed to update cart');

  factory CartItemActionResponse.fromJson(Map<String, dynamic> json) {
    return CartItemActionResponse(
      responseMessage: json['message'] as String?,
      itemId: (json['itemId'] ?? json['id']) as String? ?? '',
      productId: json['productId'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      isSuccess: json['success'] as bool?,
    );
  }

  @override
  String toString() =>
      'CartItemActionResponse(itemId: $itemId, productId: $productId, quantity: $quantity, message: $message)';
}
