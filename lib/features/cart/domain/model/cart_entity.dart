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
  final double totalPrice;
  final String variant;

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
  })  : itemId = itemId ?? id ?? '',
        productName = productName ?? name ?? '',
        productCoverUrl = productCoverUrl ?? imageUrl,
        finalPricePerUnit = finalPricePerUnit ?? price ?? 0.0,
        basePricePerUnit =
            basePricePerUnit ?? finalPricePerUnit ?? price ?? 0.0,
        // ignore: prefer_initializing_formals
        totalPrice = totalPrice ?? 0;

  bool get hasDiscount => basePricePerUnit > finalPricePerUnit;
  bool get isInStock => productStock > 0;
  bool get canIncrement => quantity < productStock;

  @override
  String toString() =>
      'CartItemEntity(itemId: $itemId, productName: $productName, quantity: $quantity, totalPrice: $totalPrice)';
}
