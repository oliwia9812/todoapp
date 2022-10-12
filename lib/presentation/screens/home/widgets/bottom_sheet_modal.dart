import 'package:flutter/material.dart';
import 'package:todoapp/blocs/bloc_exports.dart';
import 'package:todoapp/presentation/screens/home/widgets/categories_list.dart';
import 'package:todoapp/presentation/screens/home/widgets/date_choice_chips_list.dart';
import 'package:todoapp/presentation/widgets/custom_button.dart';
import 'package:todoapp/styles/app_decorations.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';

class AppBottomSheetModal {
  final String title;
  final String textFieldLabel;
  final String textButton;
  final VoidCallback callback;
  final GlobalKey formKey;
  final TextEditingController textEditingController;
  final bool task;
  bool? choiceChipsIsValid;

  AppBottomSheetModal({
    required this.title,
    required this.textFieldLabel,
    required this.textButton,
    required this.callback,
    required this.formKey,
    this.task = false,
    required this.textEditingController,
    this.choiceChipsIsValid,
  });

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        builder: (context) {
          return Wrap(
            children: <Widget>[
              StatefulBuilder(
                builder: (context, setState) {
                  return SafeArea(
                    minimum: const EdgeInsets.symmetric(
                        horizontal: 36.0, vertical: 24.0),
                    child: _buildBody(context, setState),
                  );
                },
              ),
            ],
          );
        },
        backgroundColor: Theme.of(context).colorScheme.surface);
  }

  Widget _buildBody(BuildContext context, StateSetter setState) {
    final CategoryState categoryState =
        BlocProvider.of<CategoryBloc>(context).state;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildForm(context),
          if (task) _buildCategories(context, setState, categoryState),
          if (task && choiceChipsIsValid == false) _buildErrorMessage(),
          if (task) _buildDate(context),
          _buildFooter(setState, context),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textFieldLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey,
            child: TextFormField(
              controller: textEditingController,
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: AppDecorations.formField(context),
              style: AppTextStyles.textFieldInput(),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(
    BuildContext context,
    StateSetter setState,
    CategoryState state,
  ) {
    if (state is CategoryLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state.categoriesListInModal.isNotEmpty
              ? Text(
                  'Select category',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              : const SizedBox.shrink(),
          const SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 28.0, 4.0),
            scrollDirection: Axis.horizontal,
            child: CategoriesList(
              inModal: true,
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Future<void> _validateCategories(BuildContext context) async {
    String? selectedCategory =
        BlocProvider.of<CategoryBloc>(context).selectedCategoryInModal;

    if (selectedCategory != null) {
      choiceChipsIsValid = true;
    } else {
      choiceChipsIsValid = false;
    }
  }

  Widget _buildErrorMessage() {
    return Text(
      'Please choose category',
      style: AppTextStyles.errorMessage(),
    );
  }

  Widget _buildFooter(StateSetter setState, BuildContext context) {
    return CustomButton(
        inTaskModal: task ? true : false,
        callback: () {
          setState(() {
            callback();
            _validateCategories(context);
          });
        },
        textButton: textButton);
  }

  Widget _buildDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Date',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const DateChoiceChipsList(),
        ],
      ),
    );
  }
}
