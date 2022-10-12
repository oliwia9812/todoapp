import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/blocs/categories/models/category.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/models/category_model.dart';
import 'package:todoapp/mappers/category_mapper.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final DatabaseHelper db;

  static CategoryModel baseCategory =
      CategoryModel(categoryName: Constants.baseCategoryName, isSelected: true);

  List<CategoryModel> allCategories = [];
  List<CategoryModel> allCategoriesInModal = [];
  String? selectedCategory = 'All';
  String? selectedCategoryInModal;

  CategoryBloc({required this.db}) : super(CategoryLoading()) {
    on<GetCategories>(_onGetCategories);
    on<AddCategory>(_onAddCategory);
    on<SelectCategory>(_onSelectCategory);
    on<SelectCategoryInModal>(_onSelectCategoryInModal);
    on<ResetCategories>(_onResetCategories);
    on<ResetCategoriesInModal>(_onResetCategoriesInModal);
    on<RemoveCategory>(_onRemoveCategory);
  }

  FutureOr<void> _onResetCategories(
      ResetCategories event, Emitter<CategoryState> emit) {
    emit(CategoryLoading());

    allCategories = allCategories.map((category) {
      if (category.categoryName == Constants.baseCategoryName) {
        return category.copyWith(isSelected: true);
      } else if (category.categoryName != Constants.baseCategoryName &&
          category.isSelected == true) {
        return category.copyWith(isSelected: false);
      } else {
        return category;
      }
    }).toList();

    emit(CategoryLoaded(
        categoriesList: allCategories,
        categoriesListInModal: allCategoriesInModal));
  }

  FutureOr<void> _onResetCategoriesInModal(
      ResetCategoriesInModal event, Emitter<CategoryState> emit) {
    emit(CategoryLoading());

    selectedCategoryInModal = null;

    allCategoriesInModal = allCategoriesInModal.map((category) {
      if (category.isSelected == true) {
        return category.copyWith(isSelected: false);
      }
      return category;
    }).toList();

    emit(CategoryLoaded(
        categoriesList: allCategories,
        categoriesListInModal: allCategoriesInModal));
  }

  Future<void> _onGetCategories(
      GetCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    List<Category> categories = await db.getCategories();

    allCategories.clear();

    allCategories.insert(0, baseCategory);
    allCategories.addAll(categories.mapToListCategoryModel());
    allCategoriesInModal = categories.mapToListCategoryModel();

    emit(CategoryLoaded(
        categoriesList: allCategories,
        categoriesListInModal: allCategoriesInModal));
  }

  Future<void> _onAddCategory(
      AddCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    Category category = event.category.mapToCategory();

    await db.insertCategory(category);
    allCategories.add(category.mapToCategoryModel());
    allCategoriesInModal.add(category.mapToCategoryModel());

    emit(CategoryLoaded(
        categoriesList: allCategories,
        categoriesListInModal: allCategoriesInModal));
  }

  FutureOr<void> _onSelectCategory(
      SelectCategory event, Emitter<CategoryState> emit) {
    emit(CategoryLoading());

    selectedCategory = event.selectedCategory;

    allCategories = allCategories.map((category) {
      if (category.categoryName == event.selectedCategory) {
        return category.copyWith(isSelected: true);
      } else {
        return category.copyWith(isSelected: false);
      }
    }).toList();

    emit(CategoryLoaded(
        categoriesList: allCategories,
        categoriesListInModal: allCategoriesInModal));
  }

  FutureOr<void> _onSelectCategoryInModal(
      SelectCategoryInModal event, Emitter<CategoryState> emit) {
    emit(CategoryLoading());

    selectedCategoryInModal = event.selectedCategoryInModal;

    allCategoriesInModal = allCategoriesInModal.map((category) {
      if (category.categoryName == event.selectedCategoryInModal) {
        return category.copyWith(isSelected: true);
      } else {
        return category.copyWith(isSelected: false);
      }
    }).toList();

    emit(CategoryInModalChanged());

    emit(CategoryLoaded(
        categoriesList: allCategories,
        categoriesListInModal: allCategoriesInModal));
  }

  Future<void> _onRemoveCategory(
      RemoveCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    await db.deleteCategory(event.category);

    add(GetCategories());
  }
}
