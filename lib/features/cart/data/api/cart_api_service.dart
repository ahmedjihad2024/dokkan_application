import 'package:dio/dio.dart';

import '../request/add_cart_item_request.dart';
import '../request/decrement_cart_item_request.dart';
import '../request/update_cart_item_request.dart';

abstract class CartApiService {
  Future<Response> getCart();
  Future<Response> addCartItem(AddCartItemRequest request);
  Future<Response> updateCartItem(UpdateCartItemRequest request);
  Future<Response> decrementCartItem(DecrementCartItemRequest request);
  Future<Response> deleteCartItem(String itemId);
}

class CartApiServiceImpl implements CartApiService {
  final Dio _dio;

  CartApiServiceImpl(this._dio);

  @override
  Future<Response> getCart() {
    return _dio.get('/api/cart');
  }

  @override
  Future<Response> addCartItem(AddCartItemRequest request) {
    return _dio.post(
      '/api/cart/items',
      data: request.toJson(),
    );
  }

  @override
  Future<Response> updateCartItem(UpdateCartItemRequest request) {
    return _dio.put(
      '/api/cart/items/${request.id}',
      data: request.toJson(),
    );
  }

  @override
  Future<Response> decrementCartItem(DecrementCartItemRequest request) {
    return _dio.post(
      '/api/cart/items/decrement',
      data: request.toJson(),
    );
  }

  @override
  Future<Response> deleteCartItem(String itemId) {
    return _dio.delete('/api/cart/items/$itemId');
  }
}
