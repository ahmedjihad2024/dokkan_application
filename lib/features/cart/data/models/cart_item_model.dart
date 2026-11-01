class CartItemModel {
  final String id;
  final String name;
  final String variant;
  final double price;
  final int quantity;
  final String emoji;
  final String? imageUrl;

  const CartItemModel({
    required this.id,
    required this.name,
    required this.variant,
    required this.price,
    this.quantity = 1,
    this.emoji = '⌚',
    this.imageUrl,
  });

  CartItemModel copyWith({
    String? id,
    String? name,
    String? variant,
    double? price,
    int? quantity,
    String? emoji,
    String? imageUrl,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      variant: variant ?? this.variant,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      emoji: emoji ?? this.emoji,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

