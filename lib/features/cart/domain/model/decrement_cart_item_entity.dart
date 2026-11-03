class DecrementCartItemEntity {
  final String message;
  final String itemId;
  final String productId;
  final int quantity;

  const DecrementCartItemEntity({
    required this.message,
    required this.itemId,
    required this.productId,
    required this.quantity,
  });

  bool get isRemoved => quantity <= 0;

  @override
  String toString() =>
      'DecrementCartItemEntity(itemId: $itemId, productId: $productId, quantity: $quantity, message: $message)';
}

