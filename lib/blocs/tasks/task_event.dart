part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TaskEvent {
  final bool changeToBaseCategory;

  const GetTasks({this.changeToBaseCategory = false});
}

class AddTask extends TaskEvent {
  final String taskName;

  const AddTask({required this.taskName});
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  const UpdateTask({required this.task});
}

class RemoveTask extends TaskEvent {
  final int taskId;

  const RemoveTask({required this.taskId});
}

class RemoveTasksWithCategory extends TaskEvent {
  final String selectedCategory;

  const RemoveTasksWithCategory({required this.selectedCategory});
}

class SetTaskDate extends TaskEvent {
  final DateTime date;

  const SetTaskDate({required this.date});
}

class GetTasksByDate extends TaskEvent {
  final DateTime selectedDate;

  const GetTasksByDate({required this.selectedDate});
}
