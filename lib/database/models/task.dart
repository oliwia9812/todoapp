import 'package:equatable/equatable.dart';

class Task extends Equatable {
  Task({
    this.id,
    required this.isCompleted,
    required this.taskName,
  });

  final int? id;
  int isCompleted;
  final String taskName;

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
