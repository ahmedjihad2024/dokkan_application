import '../api/product_details_api_service.dart';
import '../response/product_details_response.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsResponse> getProductDetails(String id);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ProductDetailsApiService _apiService;

  ProductDetailsRemoteDataSourceImpl(this._apiService);

  @override
  Future<ProductDetailsResponse> getProductDetails(String id) =>
      _apiService.getProductDetails(id);
}

