import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  TaskModel({
    required this.taskName,
    required this.isCompleted,
  });

  bool isCompleted;
  final String taskName;

  @override
  List<Object?> get props => [
        isCompleted,
        taskName,
      ];
}
