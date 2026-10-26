class ManageProductItem {
  final String id;
  final String name;
  final String arabicName;
  final double price;
  final int stock;
  final String? imageAsset;
  final String emoji;

  const ManageProductItem({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.price,
    required this.stock,
    this.imageAsset,
    this.emoji = '👜',
  });

  ManageProductItem copyWith({
    String? id,
    String? name,
    String? arabicName,
    double? price,
    int? stock,
    String? imageAsset,
    String? emoji,
  }) {
    return ManageProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      arabicName: arabicName ?? this.arabicName,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      imageAsset: imageAsset ?? this.imageAsset,
      emoji: emoji ?? this.emoji,
    );
  }
}
