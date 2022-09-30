part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  List<TaskModel> tasksList;

  TaskLoaded({required this.tasksList});
}
