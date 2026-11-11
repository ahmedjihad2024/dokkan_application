import 'package:dio/dio.dart';
import 'package:dokkan/core/network/dio_factory.dart';

import '../request/add_to_cart_request.dart';

abstract class AddToCartApiService {
  Future<Response> addToCart(AddToCartRequest request);
}

class AddToCartApiServiceImpl implements AddToCartApiService {
  final DioFactory _dio;

  AddToCartApiServiceImpl(this._dio);

  @override
  Future<Response> addToCart(AddToCartRequest request) {
    return _dio.request(
      '/api/cart/items',
      method: RequestMethod.POST,
      body: request.toJson(),
    );
  }
}
