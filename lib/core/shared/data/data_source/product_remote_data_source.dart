import '../api/product_api_service.dart';
import '../request/products_request.dart';
import '../response/products_response.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponse> getProducts(ProductsRequest request);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductApiService _apiService;

  ProductRemoteDataSourceImpl(this._apiService);

  @override
  Future<ProductsResponse> getProducts(ProductsRequest request) {
    return _apiService.getProducts(request);
  }
}
