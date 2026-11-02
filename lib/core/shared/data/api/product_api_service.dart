import 'package:dio/dio.dart';

import '../request/products_request.dart';
import '../response/products_response.dart';

abstract class ProductApiService {
  Future<ProductsResponse> getProducts(ProductsRequest request);
}

class ProductApiServiceImpl implements ProductApiService {
  final Dio _dio;

  ProductApiServiceImpl(this._dio);

  @override
  Future<ProductsResponse> getProducts(ProductsRequest request) async {
    final response = await _dio.get(
      '/api/products',
      data: request.toQueryParameters(),
    );

    return ProductsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

