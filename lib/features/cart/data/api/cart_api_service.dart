import 'package:dio/dio.dart';

import '../request/decrement_cart_item_request.dart';

abstract class CartApiService {
  Future<Response> getCart();
  Future<Response> decrementCartItem(DecrementCartItemRequest request);
}

class CartApiServiceImpl implements CartApiService {
  final Dio _dio;

  CartApiServiceImpl(this._dio);

  @override
  Future<Response> getCart() {
    return _dio.get('/api/cart');
  }

  @override
  Future<Response> decrementCartItem(DecrementCartItemRequest request) {
    return _dio.post(
      '/api/cart/items/decrement',
      data: request.toJson(),
    );
  }
}

