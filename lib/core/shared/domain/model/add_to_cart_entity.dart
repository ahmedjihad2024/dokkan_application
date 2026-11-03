class AddToCartEntity {
  final String message;
  final String id;
  final String productId;
  final int quantity;

  const AddToCartEntity({
    required this.message,
    required this.id,
    required this.productId,
    required this.quantity,
  });

  @override
  String toString() =>
      'AddToCartEntity(id: $id, productId: $productId, quantity: $quantity, message: $message)';
}

