import 'package:dio/dio.dart';

import '../response/categories_response.dart';

abstract class CategoryApiService {
  Future<CategoriesResponse> getCategories();
}

class CategoryApiServiceImpl implements CategoryApiService {
  final Dio _dio;

  CategoryApiServiceImpl(this._dio);

  @override
  Future<CategoriesResponse> getCategories() async {
    final response = await _dio.get('/api/categories');

    if (response.data is Map<String, dynamic>) {
      return CategoriesResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } else if (response.data is List<dynamic>) {
      return CategoriesResponse.fromJson({
        'categories': response.data,
      });
    }

    return const CategoriesResponse();
  }
}

