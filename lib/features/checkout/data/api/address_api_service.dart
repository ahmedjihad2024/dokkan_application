import 'package:dio/dio.dart';

import '../request/address_request.dart';

abstract class AddressApiService {
  Future<Response> createAddress(AddressRequest request);
  Future<Response> getAddresses();
  Future<Response> deleteAddress(String id);
}

class AddressApiServiceImpl implements AddressApiService {
  final Dio _dio;

  AddressApiServiceImpl(this._dio);

  @override
  Future<Response> createAddress(AddressRequest request) {
    return _dio.post(
      '/api/addresses',
      data: request.toJson(),
    );
  }

  @override
  Future<Response> getAddresses() {
    return _dio.get('/api/addresses');
  }

  @override
  Future<Response> deleteAddress(String id) {
    return _dio.delete('/api/addresses/$id');
  }
}
