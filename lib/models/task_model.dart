import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  TaskModel({
    this.id,
    this.category,
    required this.isCompleted,
    required this.taskName,
    required this.date,
  });

  final int? id;
  final String? category;
  bool isCompleted;
  final String taskName;
  final DateTime date;

  TaskModel copyWith({
    int? id,
    String? category,
    bool? isCompleted,
    String? taskName,
    DateTime? date,
  }) {
    return TaskModel(
      id: id ?? this.id,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      taskName: taskName ?? this.taskName,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'name': taskName,
      'isCompleted': isCompleted,
      'date': date,
    };
  }

  @override
  List<Object?> get props => [
        id,
        category,
        isCompleted,
        taskName,
        date,
      ];
}
