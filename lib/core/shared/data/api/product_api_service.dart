import 'package:dokkan/core/network/dio_factory.dart';

import '../request/products_request.dart';
import '../response/products_response.dart';

abstract class ProductApiService {
  Future<ProductsResponse> getProducts(ProductsRequest request);
  Future<void> deleteProduct(String id);
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
  @override
  Future<void> deleteProduct(String id) async {
    await _dio.request(
      '/api/products/$id',
      method: RequestMethod.DELETE, 
    );
  }
}
