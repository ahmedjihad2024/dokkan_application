import 'package:dio/dio.dart';

import '../request/edit_address_request.dart';

abstract class EditAddressApiService {
  Future<Response> updateAddress(String id, EditAddressRequest request);
  Future<Response> getAddressById(String id);
  Future<Response> createAddress(EditAddressRequest request);
}

class EditAddressApiServiceImpl implements EditAddressApiService {
  final Dio _dio;

  EditAddressApiServiceImpl(this._dio);

  @override
  Future<Response> updateAddress(String id, EditAddressRequest request) {
    return _dio.put(
      '/api/addresses/$id',
      data: request.toJson(),
    );
  }

  @override
  Future<Response> getAddressById(String id) {
    return _dio.get('/api/addresses/$id');
  }

  @override
  Future<Response> createAddress(EditAddressRequest request) {
    return _dio.post(
      '/api/addresses',
      data: request.toJson(),
    );
  }
}

