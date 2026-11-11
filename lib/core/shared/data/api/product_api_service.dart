import 'package:dokkan/core/network/dio_factory.dart';

import '../request/create_product_request.dart';
import '../request/products_request.dart';
import '../request/update_product_request.dart';
import '../response/product_mutation_response.dart';
import '../response/products_response.dart';

abstract class ProductApiService {
  Future<ProductsResponse> getProducts(ProductsRequest request);
  Future<ProductMutationResponse> createProduct(CreateProductRequest request);
  Future<ProductMutationResponse> updateProduct(UpdateProductRequest request);
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
  Future<ProductMutationResponse> createProduct(
    CreateProductRequest request,
  ) async {
    final response = await _dio.request(
      '/api/products',
      method: RequestMethod.POST,
      body: request.toJson(),
    );

    return ProductMutationResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<ProductMutationResponse> updateProduct(
    UpdateProductRequest request,
  ) async {
    final response = await _dio.request(
      '/api/products/${request.id}',
      method: RequestMethod.PUT,
      body: request.toJson(),
    );

    return ProductMutationResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _dio.request(
      '/api/products/$id',
      method: RequestMethod.DELETE,
    );
  }
}
