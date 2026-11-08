import '../../domain/model/category_entity.dart';
import '../response/categories_response.dart';

extension CategoryItemResponseMapper on CategoryItemResponse {
  CategoryEntity toDomain() {
    final effectiveId = id.isNotEmpty ? id : name;
    final effectiveName = name.isNotEmpty ? name : id;
    return CategoryEntity(
      id: effectiveId,
      name: effectiveName,
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

