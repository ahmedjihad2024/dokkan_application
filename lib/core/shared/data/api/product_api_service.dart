import 'package:dio/dio.dart';
import 'package:dokkan/core/network/dio_factory.dart';

import '../request/products_request.dart';
import '../response/products_response.dart';

abstract class ProductApiService {
  Future<ProductsResponse> getProducts(ProductsRequest request);
}

class ProductApiServiceImpl implements ProductApiService {
  final DioFactory _dio;

  ProductApiServiceImpl(this._dio);

  @override
  Future<ProductsResponse> getProducts(ProductsRequest request) async {
    final response = await _dio.request(
      '/api/products',
      method: RequestMethod.GET,
      body: request.toJson(),
    );

    return ProductsResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
