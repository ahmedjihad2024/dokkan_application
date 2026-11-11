import 'package:dokkan/core/network/dio_factory.dart';

import '../request/offers_request.dart';
import '../response/offers_response.dart';

abstract class HomeApiService {
  Future<OffersResponse> getOffers(OffersRequest request);
}

class HomeApiServiceImpl implements HomeApiService {
  final DioFactory _dio;

  HomeApiServiceImpl(this._dio);

  @override
  Future<OffersResponse> getOffers(OffersRequest request) async {
    final response = await _dio.request(
      '/api/offers',
      method: RequestMethod.GET,
      body: request.toQueryParameters(),
    );

    return OffersResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
