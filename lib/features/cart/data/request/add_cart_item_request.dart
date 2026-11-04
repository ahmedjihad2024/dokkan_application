class AddCartItemRequest {
  final String productId;
  final int quantity;

  const AddCartItemRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };

  @override
  String toString() =>
      'AddCartItemRequest(productId: $productId, quantity: $quantity)';
}
