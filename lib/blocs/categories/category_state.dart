part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categoriesList;
  final List<CategoryModel> categoriesListInModal;

  const CategoryLoaded(
      {required this.categoriesList, required this.categoriesListInModal});
}

class CategoryInModalChanged extends CategoryState {}

class CategoryInModalNotChanged extends CategoryState {}
