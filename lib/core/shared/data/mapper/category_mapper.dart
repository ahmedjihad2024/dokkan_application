import '../../domain/model/category_entity.dart';
import '../response/categories_response.dart';

extension CategoryItemResponseMapper on CategoryItemResponse {
  CategoryEntity toDomain() {
    return CategoryEntity(
      id: id,
      name: name,
      description: description,
      coverPictureUrl: coverPictureUrl,
    );
  }
}

extension CategoriesResponseMapper on CategoriesResponse {
  List<CategoryEntity> toDomain() {
    return categories.map((cat) => cat.toDomain()).toList();
  }
}

