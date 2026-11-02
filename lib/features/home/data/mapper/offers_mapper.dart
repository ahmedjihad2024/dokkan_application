import '../../domain/model/offer_entity.dart';
import '../response/offers_response.dart';

extension OfferItemResponseMapper on OfferItemResponse {
  OfferEntity toDomain() {
    return OfferEntity(
      id: id,
      name: name,
      description: description,
      coverUrl: coverUrl,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }
}

extension OffersResponseMapper on OffersResponse {
  OffersPaginationEntity toDomain() {
    final data = offers;
    return OffersPaginationEntity(
      items: data?.items.map((item) => item.toDomain()).toList() ?? [],
      page: data?.page ?? 1,
      pageSize: data?.pageSize ?? 0,
      totalCount: data?.totalCount ?? 0,
      hasNextPage: data?.hasNextPage ?? false,
      hasPreviousPage: data?.hasPreviousPage ?? false,
    );
  }
}

