import '../../../../core/network/base_response.dart';

class DecrementCartItemResponse implements BasicResponse {
  final String? responseMessage;
  final String itemId;
  final String productId;
  final int quantity;
  final bool? isSuccess;

  const DecrementCartItemResponse({
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
      responseMessage ?? (success ? 'Item removed from cart.' : 'Failed to decrement cart item');

  factory DecrementCartItemResponse.fromJson(Map<String, dynamic> json) {
    return DecrementCartItemResponse(
      responseMessage: json['message'] as String?,
      itemId: json['itemId'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      isSuccess: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (responseMessage != null) 'message': responseMessage,
        'itemId': itemId,
        'productId': productId,
        'quantity': quantity,
        if (isSuccess != null) 'success': isSuccess,
      };

  @override
  String toString() =>
      'DecrementCartItemResponse(itemId: $itemId, productId: $productId, quantity: $quantity, message: $message)';
}

