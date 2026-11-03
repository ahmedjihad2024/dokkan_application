import 'package:dio/dio.dart';

import '../request/add_to_cart_request.dart';

abstract class AddToCartApiService {
  Future<Response> addToCart(AddToCartRequest request);
}

class AddToCartApiServiceImpl implements AddToCartApiService {
  final Dio _dio;

  AddToCartApiServiceImpl(this._dio);

  @override
  Future<Response> addToCart(AddToCartRequest request) {
    return _dio.post(
      '/api/cart/items',
      data: request.toJson(),
    );
  }
}

