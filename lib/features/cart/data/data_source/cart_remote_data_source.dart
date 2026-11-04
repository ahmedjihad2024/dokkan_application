import '../api/cart_api_service.dart';
import '../request/add_cart_item_request.dart';
import '../request/decrement_cart_item_request.dart';
import '../request/update_cart_item_request.dart';
import '../response/cart_item_action_response.dart';
import '../response/decrement_cart_item_response.dart';
import '../response/delete_cart_item_response.dart';
import '../response/get_cart_response.dart';

abstract class CartRemoteDataSource {
  Future<GetCartResponse> getCart();
  Future<CartItemActionResponse> addCartItem(AddCartItemRequest request);
  Future<CartItemActionResponse> updateCartItem(UpdateCartItemRequest request);
  Future<DecrementCartItemResponse> decrementCartItem(
    DecrementCartItemRequest request,
  );
  Future<DeleteCartItemResponse> deleteCartItem(String itemId);
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
  Future<CartItemActionResponse> addCartItem(AddCartItemRequest request) async {
    final response = await _apiService.addCartItem(request);
    return CartItemActionResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<CartItemActionResponse> updateCartItem(
    UpdateCartItemRequest request,
  ) async {
    final response = await _apiService.updateCartItem(request);
    return CartItemActionResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
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

  @override
  Future<DeleteCartItemResponse> deleteCartItem(String itemId) async {
    await _apiService.deleteCartItem(itemId);
    return const DeleteCartItemResponse();
  }
}
