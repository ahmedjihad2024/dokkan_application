import 'package:dio/dio.dart';
import 'package:dokkan/core/network/dio_factory.dart';

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
  final DioFactory _dio;

  CartApiServiceImpl(this._dio);

  @override
  Future<Response> getCart() {
    return _dio.request('/api/cart', method: RequestMethod.GET);
  }

  @override
  Future<Response> addCartItem(AddCartItemRequest request) {
    return _dio.request(
      '/api/cart/items',
      method: RequestMethod.POST,
      body: request.toJson(),
    );
  }

  @override
  Future<Response> updateCartItem(UpdateCartItemRequest request) {
    return _dio.request(
      '/api/cart/items/${request.id}',
      method: RequestMethod.PUT,
      body: request.toJson(),
    );
  }

  @override
  Future<Response> decrementCartItem(DecrementCartItemRequest request) {
    return _dio.request(
      '/api/cart/items/decrement',
      method: RequestMethod.POST,
      body: request.toJson(),
    );
  }

  @override
  Future<Response> deleteCartItem(String itemId) {
    return _dio.request(
      '/api/cart/items/$itemId',
      method: RequestMethod.DELETE,
      body: {'id': itemId},
    );
  }
}
