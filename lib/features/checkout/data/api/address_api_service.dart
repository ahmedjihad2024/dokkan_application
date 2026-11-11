import 'package:dio/dio.dart';
import 'package:dokkan/core/network/dio_factory.dart';

import '../request/address_request.dart';

abstract class AddressApiService {
  Future<Response> createAddress(AddressRequest request);
  Future<Response> getAddresses();
  Future<Response> deleteAddress(String id);
}

class AddressApiServiceImpl implements AddressApiService {
  final DioFactory _dio;

  AddressApiServiceImpl(this._dio);

  @override
  Future<Response> createAddress(AddressRequest request) {
    return _dio.request(
      '/api/addresses',
      method: RequestMethod.POST,
      body: request.toJson(),
    );
  }

  @override
  Future<Response> getAddresses() {
    return _dio.request('/api/addresses', method: RequestMethod.GET);
  }

  @override
  Future<Response> deleteAddress(String id) {
    return _dio.request('/api/addresses/$id', method: RequestMethod.DELETE);
  }
}
