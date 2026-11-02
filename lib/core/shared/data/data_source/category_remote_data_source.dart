import '../api/category_api_service.dart';
import '../response/categories_response.dart';

abstract class CategoryRemoteDataSource {
  Future<CategoriesResponse> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final CategoryApiService _apiService;

  CategoryRemoteDataSourceImpl(this._apiService);

  @override
  Future<CategoriesResponse> getCategories() {
    return _apiService.getCategories();
  }
}
