import 'package:todoapp/blocs/categories/models/category.dart';
import 'package:todoapp/models/category_model.dart';

extension CategoryMapper on Category {
  CategoryModel mapToCategoryModel() {
    return CategoryModel(
      categoryName: categoryName,
      id: id,
    );
  }
}

extension CategoryModelMapper on CategoryModel {
  Category mapToCategory() {
    return Category(
      categoryName: categoryName,
      id: id,
    );
  }
}

extension CategoryListMapper on List<Category> {
  List<CategoryModel> mapToListCategoryModel() {
    return map(
      (category) => category.mapToCategoryModel(),
    ).toList();
  }
}
