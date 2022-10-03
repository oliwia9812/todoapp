import 'package:flutter/material.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/styles/app_decorations.dart';
import 'package:todoapp/styles/app_icons.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';
import 'package:todoapp/ui/screens/home/widgets/calendar.dart';
import 'package:todoapp/ui/screens/home/widgets/tasks_list.dart';
import 'package:todoapp/ui/widgets/cutom_button.dart';
import '../../../blocs/bloc_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskController = TextEditingController();
  final _formFieldKey = GlobalKey<FormFieldState>();

  List<String> categoriesList = [
    'All tasks',
  ];

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(GetTasks());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.blue,
            onPressed: _buildShowModalBottom,
            child: const Icon(AppIcons.add),
          ),
          body: SafeArea(
            minimum: const EdgeInsets.fromLTRB(24.0, 64.0, 0.0, 64.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 48.0,
                      height: 48.0,
                    ),
                    const SizedBox(height: 36.0),
                    const Calendar(),
                    const SizedBox(height: 36.0),
                    Row(
                      children: [
                        Text(
                          'Tasks',
                          style: AppTextStyles.title(color: AppColors.white),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          BlocProvider.of<TaskBloc>(context)
                              .tasksNumbers
                              .toString(),
                          style:
                              AppTextStyles.title(color: AppColors.lightGray),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: _buildChoiceChips()),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    _buildBodyList(state: state),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBodyList({required TaskState state}) {
    if (state is TasksLoading) {
      return const Expanded(
        child: Align(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.lightGray,
            color: AppColors.blue,
          ),
        ),
      );
    } else if (state is TasksLoaded) {
      return TasksList(
        tasks: state.tasksList,
      );
    } else if (state is TasksEmpty) {
      return Expanded(
        child: Align(
          child: Text(
            'Add your first task',
            style: AppTextStyles.standard(),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> _buildShowModalBottom() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        backgroundColor: AppColors.gray,
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 33.0, vertical: 64.0),
            height: 300.0,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task name',
                      style: AppTextStyles.bottomModalTitle(),
                    ),
                    Form(
                      child: TextFormField(
                        key: _formFieldKey,
                        controller: taskController,
                        style: AppTextStyles.textField(),
                        cursorColor: AppColors.blue,
                        decoration: AppDecorations.formField(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'Task name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      callback: () async {
                        if (_formFieldKey.currentState!.validate()) {
                          final task = TaskModel(
                              taskName: taskController.text,
                              isCompleted: false);

                          BlocProvider.of<TaskBloc>(context)
                              .add(AddTask(task: task));

                          Navigator.pop(context);
                          taskController.clear();
                        }
                      },
                      textButton: 'Add task',
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildChoiceChips() {
    List<Widget> allcategories = [];

    for (int i = 0; i < categoriesList.length; i++) {
      Padding categoryButton = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ChoiceChip(
          label: Text(
            categoriesList[i],
            style: AppTextStyles.choiceChip(
                color: selectedCategoryIndex == i
                    ? AppColors.white
                    : AppColors.lightGray),
          ),
          selected: selectedCategoryIndex == i,
          backgroundColor: AppColors.gray,
          selectedColor: AppColors.blue,
          elevation: 0.0,
          pressElevation: 0.0,
          side: const BorderSide(color: AppColors.gray),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedCategoryIndex = i;
              }
            });
          },
        ),
      );

      allcategories.add(categoryButton);
    }
    allcategories.add(
      const Icon(
        AppIcons.add,
        color: AppColors.lightGray,
      ),
    );
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 8.0),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allcategories,
      ),
    );
  }
}
