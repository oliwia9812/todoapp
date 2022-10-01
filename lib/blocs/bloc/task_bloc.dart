import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/database/models/task.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/mappers/task_mapper.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final db = DatabaseHelper();

  TaskBloc() : super(TaskLoading()) {
    on<GetTasks>((event, emit) async {
      List<Task> tasks = await db.getTasks();

      emit(
        TaskLoaded(
          tasksList: tasks.mapToListTaskModel(),
        ),
      );
    });

    on<AddTask>((event, emit) async {
      emit(TaskLoading());

      Task task = event.task.mapToTask();
      await db.insertTask(task);

      add(GetTasks());
    });

    on<UpdateTask>((event, emit) async {
      emit(TaskLoading());

      TaskModel updatedTask =
          event.task.copyWith(isCompleted: !event.task.isCompleted);
      Task task = updatedTask.mapToTask();

      await db.updateTask(task);

      add(GetTasks());
    });

    on<RemoveTask>((event, emit) async {
      await db.deleteTask(event.taskId);

      add(GetTasks());
    });
  }
}
