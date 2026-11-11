import '../api/product_api_service.dart';
import '../request/create_product_request.dart';
import '../request/products_request.dart';
import '../request/update_product_request.dart';
import '../response/product_mutation_response.dart';
import '../response/products_response.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponse> getProducts(ProductsRequest request);
  Future<ProductMutationResponse> createProduct(CreateProductRequest request);
  Future<ProductMutationResponse> updateProduct(UpdateProductRequest request);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductApiService _apiService;

  ProductRemoteDataSourceImpl(this._apiService);

  @override
  Future<ProductsResponse> getProducts(ProductsRequest request) {
    return _apiService.getProducts(request);
  }

  @override
  Future<ProductMutationResponse> createProduct(CreateProductRequest request) {
    return _apiService.createProduct(request);
  }

  @override
  Future<ProductMutationResponse> updateProduct(UpdateProductRequest request) {
    return _apiService.updateProduct(request);
  }

  @override
  Future<void> deleteProduct(String id) {
    return _apiService.deleteProduct(id);
  }
}
