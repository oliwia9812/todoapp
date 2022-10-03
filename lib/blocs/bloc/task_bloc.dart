import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/database/models/task.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/mappers/task_mapper.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper db;
  int tasksNumbers = 0;

  TaskBloc({required this.db}) : super(TasksLoading()) {
    on<GetTasks>((event, emit) async {
      List<Task> allTasks = await db.getTasks();
      List<Task> completedTasks =
          allTasks.where((element) => element.isCompleted == 1).toList();
      List<Task> uncompletedTasks =
          allTasks.where((element) => element.isCompleted == 0).toList();

      List<Task> tasksList = [...uncompletedTasks, ...completedTasks];

      if (tasksList.isEmpty) {
        tasksNumbers = 0;
        emit(TasksEmpty());
        return;
      }

      tasksNumbers = tasksList.length;

      emit(
        TasksLoaded(
          tasksList: tasksList.mapToListTaskModel(),
        ),
      );
    });

    on<AddTask>((event, emit) async {
      emit(TasksLoading());

      Task task = event.task.mapToTask();
      await db.insertTask(task);

      add(GetTasks());
    });

    on<UpdateTask>((event, emit) async {
      emit(TasksLoading());

      TaskModel updatedTask =
          event.task.copyWith(isCompleted: !event.task.isCompleted);
      Task task = updatedTask.mapToTask();

      await db.updateTask(task);

      add(GetTasks());
    });

    on<RemoveTask>((event, emit) async {
      emit(TasksLoading());
      await db.deleteTask(event.taskId);

      add(GetTasks());
    });
  }
}
