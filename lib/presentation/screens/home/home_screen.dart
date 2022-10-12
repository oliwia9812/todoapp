import 'package:flutter/material.dart';
import 'package:todoapp/extensions/string_extensions.dart';
import 'package:todoapp/models/category_model.dart';
import 'package:todoapp/presentation/screens/home/widgets/bottom_sheet_modal.dart';
import 'package:todoapp/presentation/screens/home/widgets/calendar.dart';
import 'package:todoapp/presentation/screens/home/widgets/categories_list.dart';
import 'package:todoapp/presentation/screens/home/widgets/tasks_list.dart';
import 'package:todoapp/presentation/widgets/logo.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:todoapp/styles/app_icons.dart';
import 'package:todoapp/styles/app_themes.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';
import '../../../blocs/bloc_exports.dart';
import 'package:flutter_switch/flutter_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final DateTime now = DateTime.now();
  bool _light = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _buildTaskBottomModal,
        child: const Icon(AppIcons.add),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24.0, 64.0, 0, 64.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLogo(
                        small: true,
                      ),
                      FlutterSwitch(
                          inactiveToggleColor: AppColors.white,
                          inactiveIcon: const Icon(
                            Icons.dark_mode,
                            color: AppColors.backgroundDark,
                          ),
                          inactiveColor: AppColors.darkGray,
                          activeIcon: const Icon(
                            Icons.light_mode,
                            color: Colors.amber,
                          ),
                          activeColor: Colors.amber,
                          width: 60.0,
                          height: 30.0,
                          value: _light,
                          onToggle: (toggle) {
                            setState(() {
                              _light = toggle;
                              ThemeData currentMode = _light
                                  ? AppThemes.lightTheme
                                  : AppThemes.darkTheme;

                              BlocProvider.of<ThemeBloc>(context)
                                  .add(ChangeTheme(theme: currentMode));
                            });
                          }),
                    ],
                  ),
                ),
                const Calendar(),
                Row(
                  children: [
                    Text(
                      'Tasks',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 8.0),
                    BlocBuilder<TaskBloc, TaskState>(
                      builder: (context, state) {
                        if (state is TasksLoaded) {
                          return Text(
                              BlocProvider.of<TaskBloc>(context)
                                  .tasksNumbers
                                  .toString(),
                              style: Theme.of(context).textTheme.titleMedium);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 24.0, 16.0),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChoiceChips(),
                      _buildAddCategoryButton(),
                    ],
                  ),
                ),
                BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                  if (state is TasksLoading) {
                    return const Expanded(
                      child: Align(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.lightGray,
                          color: AppColors.blue,
                        ),
                      ),
                    );
                  }
                  if (state is TasksLoaded) {
                    return _buildTasksList(state: state);
                  }
                  if (state is TasksEmpty) {
                    return Expanded(
                      child: Align(
                        child: Text(
                          'Add your first task',
                          style: AppTextStyles.displaySmall(),
                        ),
                      ),
                    );
                  } else {
                    return const Text(
                        'Sorry, something went wrong. Try again!');
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksList({required TasksLoaded state}) {
    return TasksList(tasks: state.tasksList);
  }

  Widget _buildChoiceChips() {
    return const CategoriesList();
  }

  Widget _buildAddCategoryButton() {
    return GestureDetector(
      onTap: _buildCategoryBottomModal,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Icon(
          AppIcons.add,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }

  Future<dynamic> _buildCategoryBottomModal() {
    return AppBottomSheetModal(
      formKey: _formKey,
      textEditingController: _categoryController,
      title: 'Add new category',
      textFieldLabel: 'Category name',
      textButton: 'Add category',
      callback: () {
        if (_formKey.currentState!.validate()) {
          CategoryModel category = CategoryModel(
            categoryName: _categoryController.text.capitalize(),
            isSelected: false,
          );

          setState(() {
            BlocProvider.of<CategoryBloc>(context)
                .add(AddCategory(category: category));
          });

          _categoryController.clear();
          Navigator.pop(context);
        }
      },
    ).show(context).whenComplete(() => _categoryController.clear());
  }

  Future<dynamic> _buildTaskBottomModal() {
    return AppBottomSheetModal(
      task: true,
      textEditingController: _taskController,
      title: 'Add new task',
      textFieldLabel: 'Task name',
      textButton: 'Add task',
      formKey: _formKey,
      callback: () {
        if (_formKey.currentState!.validate() &&
            BlocProvider.of<CategoryBloc>(context).selectedCategoryInModal !=
                null) {
          BlocProvider.of<TaskBloc>(context)
              .add(AddTask(taskName: _taskController.text));

          BlocProvider.of<CategoryBloc>(context).add(ResetCategories());

          _taskController.clear();
          Navigator.pop(context);
        }
      },
    ).show(context).whenComplete(() {
      BlocProvider.of<CategoryBloc>(context).add(ResetCategoriesInModal());
      BlocProvider.of<TaskBloc>(context).selectedTaskDate =
          DateTime(now.year, now.month, now.day);
      _taskController.clear();
    });
  }
}
