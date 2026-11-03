import '../../../../core/network/base_response.dart';

class GetCartResponse implements BasicResponse {
  final String cartId;
  final List<CartItemResponse> cartItems;
  final String? responseMessage;
  final bool? isSuccess;

  const GetCartResponse({
    required this.cartId,
    required this.cartItems,
    this.responseMessage,
    this.isSuccess,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Cart retrieved successfully' : 'Failed to retrieve cart');

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      cartId: json['cartId'] as String? ?? '',
      cartItems: (json['cartItems'] as List<dynamic>?)
              ?.map((item) => CartItemResponse.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
      responseMessage: json['message'] as String?,
      isSuccess: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'cartId': cartId,
        'cartItems': cartItems.map((e) => e.toJson()).toList(),
        if (responseMessage != null) 'message': responseMessage,
        if (isSuccess != null) 'success': isSuccess,
      };

  @override
  String toString() =>
      'GetCartResponse(cartId: $cartId, itemsCount: ${cartItems.length})';
}

class CartItemResponse {
  final String itemId;
  final String productId;
  final String productName;
  final String? productCoverUrl;
  final int productStock;
  final double weightInGrams;
  final int quantity;
  final int discountPercentage;
  final double basePricePerUnit;
  final double finalPricePerUnit;
  final double totalPrice;

  const CartItemResponse({
    required this.itemId,
    required this.productId,
    required this.productName,
    this.productCoverUrl,
    required this.productStock,
    required this.weightInGrams,
    required this.quantity,
    required this.discountPercentage,
    required this.basePricePerUnit,
    required this.finalPricePerUnit,
    required this.totalPrice,
  });

  factory CartItemResponse.fromJson(Map<String, dynamic> json) {
    return CartItemResponse(
      itemId: json['itemId'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      productCoverUrl: json['productCoverUrl'] as String?,
      productStock: (json['productStock'] as num?)?.toInt() ?? 0,
      weightInGrams: (json['weightInGrams'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toInt() ?? 0,
      basePricePerUnit: (json['basePricePerUnit'] as num?)?.toDouble() ?? 0.0,
      finalPricePerUnit: (json['finalPricePerUnit'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'itemId': itemId,
        'productId': productId,
        'productName': productName,
        if (productCoverUrl != null) 'productCoverUrl': productCoverUrl,
        'productStock': productStock,
        'weightInGrams': weightInGrams,
        'quantity': quantity,
        'discountPercentage': discountPercentage,
        'basePricePerUnit': basePricePerUnit,
        'finalPricePerUnit': finalPricePerUnit,
        'totalPrice': totalPrice,
      };

  @override
  String toString() =>
      'CartItemResponse(itemId: $itemId, productName: $productName, quantity: $quantity, totalPrice: $totalPrice)';
}

