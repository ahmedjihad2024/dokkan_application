import 'package:dokkan/core/network/dio_factory.dart';

import '../response/product_details_response.dart';

abstract class ProductDetailsApiService {
  Future<ProductDetailsResponse> getProductDetails(String id);
}

class ProductDetailsApiServiceImpl implements ProductDetailsApiService {
  final DioFactory _dio;

  ProductDetailsApiServiceImpl(this._dio);

  @override
  Future<ProductDetailsResponse> getProductDetails(String id) async {
    final response = await _dio.request(
      '/api/products/$id',
      method: RequestMethod.GET,
    );

    return ProductDetailsResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
