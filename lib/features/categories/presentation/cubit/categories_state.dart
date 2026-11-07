import '../../domain/model/category_entity.dart';

abstract class CategoriesState {
  const CategoriesState();
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesActive extends CategoriesState {
  final List<CategoryEntity> categories;

  const CategoriesActive({required this.categories});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesActive &&
          runtimeType == other.runtimeType &&
          categories == other.categories;

  @override
  int get hashCode => categories.hashCode;
}

class CategoriesEmpty extends CategoriesState {
  const CategoriesEmpty();
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

