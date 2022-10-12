import 'package:equatable/equatable.dart';

class Task extends Equatable {
  Task({
    this.id,
    this.category,
    required this.isCompleted,
    required this.taskName,
    required this.date,
  });

  final int? id;
  final String? category;
  int isCompleted;
  final String taskName;
  final String date;

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
