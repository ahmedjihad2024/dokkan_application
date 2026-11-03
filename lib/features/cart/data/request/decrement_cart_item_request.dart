class DecrementCartItemRequest {
  final String itemId;
  final int quantity;

  const DecrementCartItemRequest({
    required this.itemId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'itemId': itemId,
        'quantity': quantity,
      };

  @override
  String toString() =>
      'DecrementCartItemRequest(itemId: $itemId, quantity: $quantity)';
}

