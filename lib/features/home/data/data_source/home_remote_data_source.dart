import '../api/home_api_service.dart';
import '../request/offers_request.dart';
import '../response/offers_response.dart';

abstract class HomeRemoteDataSource {
  Future<OffersResponse> getOffers(OffersRequest request);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiService _apiService;

  HomeRemoteDataSourceImpl(this._apiService);

  @override
  Future<OffersResponse> getOffers(OffersRequest request) {
    return _apiService.getOffers(request);
  }
}

