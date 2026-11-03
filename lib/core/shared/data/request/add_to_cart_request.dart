class AddToCartRequest {
  final String productId;
  final int quantity;

  const AddToCartRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };

  @override
  String toString() => 'AddToCartRequest(productId: $productId, quantity: $quantity)';
}

