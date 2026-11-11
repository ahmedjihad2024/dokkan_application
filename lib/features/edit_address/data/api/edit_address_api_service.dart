import 'package:dio/dio.dart';
import 'package:dokkan/core/network/dio_factory.dart';

import '../request/edit_address_request.dart';

abstract class EditAddressApiService {
  Future<Response> updateAddress(String id, EditAddressRequest request);
  Future<Response> getAddressById(String id);
  Future<Response> createAddress(EditAddressRequest request);
}

class EditAddressApiServiceImpl implements EditAddressApiService {
  final DioFactory _dio;

  EditAddressApiServiceImpl(this._dio);

  @override
  Future<Response> updateAddress(String id, EditAddressRequest request) {
    return _dio.request(
      '/api/addresses/$id',
      method: RequestMethod.PUT,
      body: request.toJson(),
    );
  }

  @override
  Future<Response> getAddressById(String id) {
    return _dio.request('/api/addresses/$id', method: RequestMethod.GET);
  }

  @override
  Future<Response> createAddress(EditAddressRequest request) {
    return _dio.request(
      '/api/addresses',
      method: RequestMethod.POST,
      body: request.toJson(),
    );
  }
}
