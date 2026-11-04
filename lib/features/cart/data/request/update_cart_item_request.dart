class UpdateCartItemRequest {
  final String id;
  final int quantity;

  const UpdateCartItemRequest({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
      };

  @override
  String toString() => 'UpdateCartItemRequest(id: $id, quantity: $quantity)';
}
