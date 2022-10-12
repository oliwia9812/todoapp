import 'package:todoapp/blocs/tasks/models/task.dart';
import 'package:todoapp/models/task_model.dart';

extension TaskMapper on Task {
  TaskModel mapToTaskModel() {
    return TaskModel(
      id: id,
      category: category,
      taskName: taskName,
      isCompleted: (isCompleted == 0) ? false : true,
      date: DateTime.parse(date),
    );
  }
}

extension TaskModelMapper on TaskModel {
  Task mapToTask() {
    return Task(
      id: id,
      category: category,
      taskName: taskName,
      isCompleted: (isCompleted) ? 1 : 0,
      date: date.toString(),
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
