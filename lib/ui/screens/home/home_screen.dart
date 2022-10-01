import 'package:flutter/material.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/database/models/task.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';
import 'package:todoapp/ui/screens/home/widgets/tasks_list.dart';
import 'package:todoapp/ui/widgets/cutom_button.dart';
import 'package:uuid/uuid.dart';
import '../../../blocs/bloc_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(GetTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const CircularProgressIndicator(
            backgroundColor: AppColors.lightGray,
          );
        } else if (state is TaskLoaded) {
          return Scaffold(
            backgroundColor: AppColors.background,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.blue,
              child: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    backgroundColor: AppColors.gray,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 33.0, vertical: 64.0),
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
                                TextField(
                                  controller: taskController,
                                  style: AppTextStyles.textField(),
                                  cursorColor: AppColors.blue,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.lightGray),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.blue,
                                      ),
                                    ),
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
                                    final task = TaskModel(
                                        taskName: taskController.text,
                                        isCompleted: false);

                                    BlocProvider.of<TaskBloc>(context)
                                        .add(AddTask(task: task));

                                    Navigator.pop(context);
                                    taskController.clear();
                                  },
                                  textButton: 'Add task',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            body: SafeArea(
              minimum:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
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
                      Text(
                        'My tasks',
                        style: AppTextStyles.title(),
                      ),
                      const SizedBox(height: 16.0),
                      TasksList(
                        tasks: state.tasksList,
                      )
                    ],
                  ),
                  if (state.tasksList.isEmpty)
                    Center(
                      child: Text(
                        'Add your first task',
                        style: AppTextStyles.standard(),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
