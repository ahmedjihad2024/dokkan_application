import '../api/cart_api_service.dart';
import '../request/decrement_cart_item_request.dart';
import '../response/decrement_cart_item_response.dart';
import '../response/get_cart_response.dart';

abstract class CartRemoteDataSource {
  Future<GetCartResponse> getCart();
  Future<DecrementCartItemResponse> decrementCartItem(
    DecrementCartItemRequest request,
  );
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final CartApiService _apiService;

  CartRemoteDataSourceImpl(this._apiService);

  @override
  Future<GetCartResponse> getCart() async {
    final response = await _apiService.getCart();
    return GetCartResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<DecrementCartItemResponse> decrementCartItem(
    DecrementCartItemRequest request,
  ) async {
    final response = await _apiService.decrementCartItem(request);
    return DecrementCartItemResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

