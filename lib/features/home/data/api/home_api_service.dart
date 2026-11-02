import 'package:dio/dio.dart';

import '../request/offers_request.dart';
import '../response/offers_response.dart';

abstract class HomeApiService {
  Future<OffersResponse> getOffers(OffersRequest request);
}

class HomeApiServiceImpl implements HomeApiService {
  final Dio _dio;

  HomeApiServiceImpl(this._dio);

  @override
  Future<OffersResponse> getOffers(OffersRequest request) async {
    final response = await _dio.get(
      '/api/offers',
      data: request.toQueryParameters(),
    );

    return OffersResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

