import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/blocs/bloc_exports.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/category_model.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';

class CategoriesList extends StatefulWidget {
  final bool inModal;

  const CategoriesList({
    this.inModal = false,
    super.key,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoaded) {
        List<Widget> categories = List.generate(
          widget.inModal
              ? state.categoriesListInModal.length
              : state.categoriesList.length,
          (index) => _buildChoiceChip(
              widget.inModal
                  ? state.categoriesListInModal[index]
                  : state.categoriesList[index],
              context),
        );
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildChoiceChip(CategoryModel category, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: GestureDetector(
        onLongPress: () => category.categoryName != Constants.baseCategoryName
            ? _showDialog(context, category.categoryName)
            : null,
        child: ChoiceChip(
          backgroundColor: widget.inModal
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).colorScheme.surface,
          selectedColor: Theme.of(context).colorScheme.primary,
          label: Text(
            category.categoryName,
            style: AppTextStyles.choiceChip(
              color: category.isSelected
                  ? AppColors.white
                  : Theme.of(context).colorScheme.tertiary,
            ),
          ),
          labelPadding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 12.0,
          ),
          selected: category.isSelected,
          pressElevation: 0.0,
          onSelected: (value) {
            setState(() {
              if (widget.inModal) {
                BlocProvider.of<CategoryBloc>(context).add(
                    SelectCategoryInModal(
                        selectedCategoryInModal: category.categoryName));
              } else {
                BlocProvider.of<CategoryBloc>(context).add(
                    SelectCategory(selectedCategory: category.categoryName));
                BlocProvider.of<TaskBloc>(context).add(const GetTasks());
              }
            });
          },
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String categoryName) {
    showCupertinoDialog(
        context: context,
        builder: ((context) {
          return CupertinoAlertDialog(
            title: Text('Do you want to delete the category $categoryName ?'),
            content: const Text('Tasks in this category will be deleted.'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  BlocProvider.of<TaskBloc>(context).add(
                      RemoveTasksWithCategory(selectedCategory: categoryName));

                  Navigator.pop(context);
                },
                child: const Text('Remove'),
              ),
            ],
          );
        }));
  }
}
