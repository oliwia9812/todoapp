part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<TaskModel> tasksList;

  const TasksLoaded({required this.tasksList});
}

class TasksEmpty extends TaskState {}
