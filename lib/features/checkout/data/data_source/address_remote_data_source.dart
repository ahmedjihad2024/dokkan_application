import '../api/address_api_service.dart';
import '../request/address_request.dart';
import '../response/address_response.dart';

abstract class AddressRemoteDataSource {
  Future<AddressResponse> createAddress(AddressRequest request);
  Future<List<AddressResponse>> getAddresses();
  Future<void> deleteAddress(String id);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final AddressApiService _apiService;

  AddressRemoteDataSourceImpl(this._apiService);

  @override
  Future<AddressResponse> createAddress(AddressRequest request) async {
    final response = await _apiService.createAddress(request);
    return AddressResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<AddressResponse>> getAddresses() async {
    final response = await _apiService.getAddresses();
    final data = response.data;
    if (data is List) {
      return data
          .map((item) => AddressResponse.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> deleteAddress(String id) async {
    await _apiService.deleteAddress(id);
  }
}
