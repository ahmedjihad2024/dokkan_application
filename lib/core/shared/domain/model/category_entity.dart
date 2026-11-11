class CategoryEntity {
  final String id;
  final String name;
  final String? description;
  final String? coverPictureUrl;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.coverPictureUrl,
  });

  @override
  String toString() =>
      'CategoryEntity(id: $id, name: $name, coverPictureUrl: $coverPictureUrl)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

