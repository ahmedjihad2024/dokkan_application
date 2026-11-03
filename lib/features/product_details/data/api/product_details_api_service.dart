import 'package:dio/dio.dart';

import '../response/product_details_response.dart';

abstract class ProductDetailsApiService {
  Future<ProductDetailsResponse> getProductDetails(String id);
}

class ProductDetailsApiServiceImpl implements ProductDetailsApiService {
  final Dio _dio;

  ProductDetailsApiServiceImpl(this._dio);

  @override
  Future<ProductDetailsResponse> getProductDetails(String id) async {
    final response = await _dio.get('/api/products/$id');

    return ProductDetailsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

