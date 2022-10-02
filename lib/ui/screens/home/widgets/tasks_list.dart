import 'package:flutter/material.dart';
import 'package:todoapp/blocs/bloc_exports.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:todoapp/styles/app_icons.dart';

class TasksList extends StatelessWidget {
  final List<TaskModel> tasks;

  const TasksList({
    required this.tasks,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: ((context, index) {
          final TaskModel task = tasks[index];
          return Dismissible(
            background: Container(
              padding: const EdgeInsets.only(right: 16.0),
              color: AppColors.red,
              child: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    AppIcons.trash,
                    color: AppColors.white,
                  )),
            ),
            key: Key(task.toString()),
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -1),
              horizontalTitleGap: 0.0,
              contentPadding: EdgeInsets.zero,
              textColor:
                  task.isCompleted ? AppColors.lightGray : AppColors.white,
              title: Text(
                task.taskName,
                style: TextStyle(
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              leading: SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  activeColor: AppColors.blue,
                  onChanged: (value) {
                    BlocProvider.of<TaskBloc>(context).add(
                      UpdateTask(task: task),
                    );
                  },
                  value: task.isCompleted,
                ),
              ),
            ),
            onDismissed: (direction) {
              int? id = task.id;
              if (id != null) {
                BlocProvider.of<TaskBloc>(context).add(RemoveTask(taskId: id));
              }
            },
          );
        }),
      ),
    );
  }
}
