import '../api/products_by_category_api_service.dart';
import '../request/products_by_category_request.dart';
import '../response/products_by_category_response.dart';

abstract class ProductsByCategoryRemoteDataSource {
  Future<ProductsByCategoryResponse> getProductsByCategory(
    ProductsByCategoryRequest request,
  );
}

class ProductsByCategoryRemoteDataSourceImpl
    implements ProductsByCategoryRemoteDataSource {
  final ProductsByCategoryApiService _apiService;

  ProductsByCategoryRemoteDataSourceImpl(this._apiService);

  @override
  Future<ProductsByCategoryResponse> getProductsByCategory(
    ProductsByCategoryRequest request,
  ) {
    return _apiService.getProductsByCategory(request);
  }
}

