part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  TaskModel task;

  AddTask({required this.task});
}

class UpdateTask extends TaskEvent {
  int taskId;

  UpdateTask({required this.taskId});
}

class RemoveTask extends TaskEvent {
  int taskId;

  RemoveTask({required this.taskId});
}
