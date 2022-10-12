part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final CategoryModel category;

  const AddCategory({required this.category});
}

class SelectCategory extends CategoryEvent {
  final String selectedCategory;

  const SelectCategory({required this.selectedCategory});
}

class SelectCategoryInModal extends CategoryEvent {
  final String selectedCategoryInModal;

  const SelectCategoryInModal({required this.selectedCategoryInModal});
}

class ResetCategories extends CategoryEvent {}

class ResetCategoriesInModal extends CategoryEvent {}

class RemoveCategory extends CategoryEvent {
  final String category;

  const RemoveCategory({required this.category});
}
