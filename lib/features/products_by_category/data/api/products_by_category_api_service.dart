import 'package:dio/dio.dart';

import '../request/products_by_category_request.dart';
import '../response/products_by_category_response.dart';

abstract class ProductsByCategoryApiService {
  Future<ProductsByCategoryResponse> getProductsByCategory(
    ProductsByCategoryRequest request,
  );
}

class ProductsByCategoryApiServiceImpl implements ProductsByCategoryApiService {
  final Dio _dio;

  ProductsByCategoryApiServiceImpl(this._dio);

  @override
  Future<ProductsByCategoryResponse> getProductsByCategory(
    ProductsByCategoryRequest request,
  ) async {
    final query = request.toQueryParameters();
    final response = await _dio.get(
      '/api/products',
      queryParameters: query,
      data: query,
    );

    return ProductsByCategoryResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
