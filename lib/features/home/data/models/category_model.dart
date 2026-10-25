class CategoryModel {
  final String id;
  final String name;
  final String? svgAsset;

  const CategoryModel({
    required this.id,
    required this.name,
    this.svgAsset,
  });
}
