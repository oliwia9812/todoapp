import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  TaskModel({
    this.id,
    required this.isCompleted,
    required this.taskName,
  });

  final int? id;
  bool isCompleted;
  final String taskName;

  TaskModel copyWith({
    int? id,
    bool? isCompleted,
    String? taskName,
  }) {
    return TaskModel(
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      taskName: taskName ?? this.taskName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': taskName,
      'isCompleted': isCompleted,
    };
  }

  @override
  List<Object?> get props => [
        id,
        isCompleted,
        taskName,
      ];
}
