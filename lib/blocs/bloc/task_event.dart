part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;

  const AddTask({required this.task});
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  const UpdateTask({required this.task});
}

class RemoveTask extends TaskEvent {
  final int taskId;

  const RemoveTask({required this.taskId});
}
