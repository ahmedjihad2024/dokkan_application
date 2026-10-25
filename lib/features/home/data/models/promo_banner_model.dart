class PromoBannerModel {
  final String id;
  final String badgeText;
  final String title;
  final String subtitle;
  final String visualEmoji;
  final String? imageAsset;

  const PromoBannerModel({
    required this.id,
    required this.badgeText,
    required this.title,
    required this.subtitle,
    required this.visualEmoji,
    this.imageAsset,
  });
}

