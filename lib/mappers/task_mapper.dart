import 'package:todoapp/database/models/task.dart';
import 'package:todoapp/models/task_model.dart';

extension TaskMapper on Task {
  TaskModel mapToTaskModel() {
    return TaskModel(
      id: id,
      taskName: taskName,
      isCompleted: (isCompleted == 0) ? false : true,
    );
  }
}

extension TaskModelMapper on TaskModel {
  Task mapToTask() {
    return Task(
      id: id,
      taskName: taskName,
      isCompleted: (isCompleted) ? 1 : 0,
    );
  }
}

extension TaskListMapper on List<Task> {
  List<TaskModel> mapToListTaskModel() {
    return map(
      (task) => task.mapToTaskModel(),
    ).toList();
  }
}
