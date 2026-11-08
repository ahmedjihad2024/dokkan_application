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
    final dynamic rawItems = json['cartItems'] ??
        json['items'] ??
        json['data'] ??
        json['cart']?['items'];
    final list = rawItems is List<dynamic> ? rawItems : <dynamic>[];

    return GetCartResponse(
      cartId: (json['cartId'] ?? json['id'] ?? '')?.toString() ?? '',
      cartItems: list
          .whereType<Map<String, dynamic>>()
          .map((item) => CartItemResponse.fromJson(item))
          .toList(),
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
    final rawItemId = (json['id'] ??
            json['itemId'] ??
            json['_id'] ??
            json['cartItemId'])
        ?.toString() ??
        '';
    final rawProductId = (json['productId'] ??
            json['product_id'] ??
            json['product']?['id'])
        ?.toString() ??
        '';
    final rawName = (json['productName'] ??
            json['name'] ??
            json['product']?['name'])
        ?.toString() ??
        '';
    final rawCover = (json['productCoverUrl'] ??
            json['coverPictureUrl'] ??
            json['coverImage'] ??
            json['image'] ??
            json['imageUrl'] ??
            json['product']?['coverPictureUrl'])
        ?.toString();
    final rawStock =
        (json['productStock'] ?? json['stock'] ?? json['product']?['stock']
                as num?)
            ?.toInt() ??
        1;
    final rawWeight =
        (json['weightInGrams'] ?? json['weight'] as num?)?.toDouble() ?? 0.0;
    final rawQuantity = (json['quantity'] as num?)?.toInt() ?? 1;
    final rawDiscount =
        (json['discountPercentage'] ?? json['discount'] as num?)?.toInt() ??
            0;
    final rawPrice = (json['finalPricePerUnit'] ??
            json['price'] ??
            json['unitPrice'] as num?)
        ?.toDouble() ??
        0.0;
    final rawBasePrice = (json['basePricePerUnit'] ??
            json['originalPrice'] ??
            rawPrice as num?)
        ?.toDouble() ??
        rawPrice;
    final rawTotal = (json['totalPrice'] ?? json['total'] as num?)
        ?.toDouble() ??
        (rawPrice * rawQuantity);

    return CartItemResponse(
      itemId: rawItemId.isNotEmpty ? rawItemId : rawProductId,
      productId: rawProductId.isNotEmpty ? rawProductId : rawItemId,
      productName: rawName,
      productCoverUrl: rawCover,
      productStock: rawStock,
      weightInGrams: rawWeight,
      quantity: rawQuantity,
      discountPercentage: rawDiscount,
      basePricePerUnit: rawBasePrice,
      finalPricePerUnit: rawPrice,
      totalPrice: rawTotal,
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

