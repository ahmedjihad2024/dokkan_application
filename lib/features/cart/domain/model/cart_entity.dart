class CartEntity {
  final String cartId;
  final List<CartItemEntity> items;

  const CartEntity({
    required this.cartId,
    required this.items,
  });

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);
  double get totalCartPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  String toString() =>
      'CartEntity(cartId: $cartId, itemsCount: ${items.length}, total: $totalCartPrice)';
}

class CartItemEntity {
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
  final double? _totalPrice;
  final String variant;
  final String emoji;

  const CartItemEntity({
    String? itemId,
    String? id,
    this.productId = '',
    String? productName,
    String? name,
    String? productCoverUrl,
    String? imageUrl,
    this.productStock = 1,
    this.weightInGrams = 0.0,
    this.quantity = 1,
    this.discountPercentage = 0,
    double? basePricePerUnit,
    double? finalPricePerUnit,
    double? price,
    double? totalPrice,
    this.variant = '',
    this.emoji = '✨',
  })  : itemId = itemId ?? id ?? '',
        productName = productName ?? name ?? '',
        productCoverUrl = productCoverUrl ?? imageUrl,
        finalPricePerUnit = finalPricePerUnit ?? price ?? 0.0,
        basePricePerUnit =
            basePricePerUnit ?? finalPricePerUnit ?? price ?? 0.0,
        _totalPrice = totalPrice;

  double get totalPrice => _totalPrice ?? (finalPricePerUnit * quantity);

  // Backward-compatible UI accessors
  String get id => itemId;
  String get name => productName;
  double get price => finalPricePerUnit;
  String? get imageUrl => productCoverUrl;

  bool get hasDiscount => discountPercentage > 0;
  bool get isInStock => productStock > 0;

  CartItemEntity copyWith({
    String? itemId,
    String? productId,
    String? productName,
    String? productCoverUrl,
    int? productStock,
    double? weightInGrams,
    int? quantity,
    int? discountPercentage,
    double? basePricePerUnit,
    double? finalPricePerUnit,
    double? totalPrice,
    String? variant,
    String? emoji,
  }) {
    return CartItemEntity(
      itemId: itemId ?? this.itemId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productCoverUrl: productCoverUrl ?? this.productCoverUrl,
      productStock: productStock ?? this.productStock,
      weightInGrams: weightInGrams ?? this.weightInGrams,
      quantity: quantity ?? this.quantity,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      basePricePerUnit: basePricePerUnit ?? this.basePricePerUnit,
      finalPricePerUnit: finalPricePerUnit ?? this.finalPricePerUnit,
      totalPrice: totalPrice ?? this.totalPrice,
      variant: variant ?? this.variant,
      emoji: emoji ?? this.emoji,
    );
  }

  @override
  String toString() =>
      'CartItemEntity(itemId: $itemId, productName: $productName, quantity: $quantity, totalPrice: $totalPrice)';
}

/// Domain alias for presentation components until Cart UI is refactored
typedef CartItemModel = CartItemEntity;
