import '../api/edit_address_api_service.dart';
import '../request/edit_address_request.dart';
import '../response/edit_address_response.dart';

abstract class EditAddressRemoteDataSource {
  Future<EditAddressResponse> updateAddress(
    String id,
    EditAddressRequest request,
  );
  Future<EditAddressResponse> getAddressById(String id);
  Future<EditAddressResponse> createAddress(EditAddressRequest request);
}

class EditAddressRemoteDataSourceImpl implements EditAddressRemoteDataSource {
  final EditAddressApiService _apiService;

  EditAddressRemoteDataSourceImpl(this._apiService);

  @override
  Future<EditAddressResponse> updateAddress(
    String id,
    EditAddressRequest request,
  ) async {
    final response = await _apiService.updateAddress(id, request);
    return EditAddressResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<EditAddressResponse> getAddressById(String id) async {
    final response = await _apiService.getAddressById(id);
    return EditAddressResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<EditAddressResponse> createAddress(EditAddressRequest request) async {
    final response = await _apiService.createAddress(request);
    return EditAddressResponse.fromJson(response.data as Map<String, dynamic>);
  }
}

