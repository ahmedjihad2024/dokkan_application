import '../../../network/base_response.dart';

class AddToCartResponse implements BasicResponse {
  final String? responseMessage;
  final String id;
  final String productId;
  final int quantity;
  final bool? isSuccess;

  const AddToCartResponse({
    this.responseMessage,
    required this.id,
    required this.productId,
    required this.quantity,
    this.isSuccess,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Item added to cart successfully.' : 'Failed to add item to cart');

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(
      responseMessage: json['message'] as String?,
      id: json['id'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      isSuccess: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (responseMessage != null) 'message': responseMessage,
        'id': id,
        'productId': productId,
        'quantity': quantity,
        if (isSuccess != null) 'success': isSuccess,
      };

  @override
  String toString() =>
      'AddToCartResponse(id: $id, productId: $productId, quantity: $quantity, message: $message)';
}

