import '../api/add_to_cart_api_service.dart';
import '../request/add_to_cart_request.dart';
import '../response/add_to_cart_response.dart';

abstract class AddToCartRemoteDataSource {
  Future<AddToCartResponse> addToCart(AddToCartRequest request);
}

class AddToCartRemoteDataSourceImpl implements AddToCartRemoteDataSource {
  final AddToCartApiService _apiService;

  AddToCartRemoteDataSourceImpl(this._apiService);

  @override
  Future<AddToCartResponse> addToCart(AddToCartRequest request) async {
    final response = await _apiService.addToCart(request);
    return AddToCartResponse.fromJson(response.data as Map<String, dynamic>);
  }
}

