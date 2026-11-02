class OfferEntity {
  final String id;
  final String name;
  final String? description;
  final String coverUrl;
  final DateTime? createdAt;

  const OfferEntity({
    required this.id,
    required this.name,
    this.description,
    required this.coverUrl,
    this.createdAt,
  });

  @override
  String toString() => 'OfferEntity(id: $id, name: $name, coverUrl: $coverUrl)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfferEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class OffersPaginationEntity {
  final List<OfferEntity> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const OffersPaginationEntity({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  String toString() =>
      'OffersPaginationEntity(page: $page, totalCount: $totalCount, itemsCount: ${items.length})';
}

