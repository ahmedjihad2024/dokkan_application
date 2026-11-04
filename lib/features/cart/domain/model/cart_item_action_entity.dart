class CartItemActionEntity {
  final String message;
  final String itemId;
  final String productId;
  final int quantity;

  const CartItemActionEntity({
    required this.message,
    required this.itemId,
    required this.productId,
    required this.quantity,
  });

  @override
  String toString() =>
      'CartItemActionEntity(itemId: $itemId, productId: $productId, quantity: $quantity, message: $message)';
}
