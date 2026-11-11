import 'package:dokkan/core/network/dio_factory.dart';

import '../response/categories_response.dart';

abstract class CategoryApiService {
  Future<CategoriesResponse> getCategories();
}

class CategoryApiServiceImpl implements CategoryApiService {
  final DioFactory _dio;

  CategoryApiServiceImpl(this._dio);

  @override
  Future<CategoriesResponse> getCategories() async {
    final response = await _dio.request(
      '/api/categories',
      method: RequestMethod.GET,
    );

    if (response.data is Map<String, dynamic>) {
      return CategoriesResponse.fromJson(response.data as Map<String, dynamic>);
    } else if (response.data is List<dynamic>) {
      return CategoriesResponse.fromJson({'categories': response.data});
    }

    return const CategoriesResponse();
  }
}

