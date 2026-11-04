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

  const CartItemEntity({
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

  bool get hasDiscount => basePricePerUnit > finalPricePerUnit;
  bool get isInStock => productStock > 0;
  bool get canIncrement => quantity < productStock;

  @override
  String toString() =>
      'CartItemEntity(itemId: $itemId, productName: $productName, quantity: $quantity, totalPrice: $totalPrice)';
}
