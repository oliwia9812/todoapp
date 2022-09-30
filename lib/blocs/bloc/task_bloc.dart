import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<TaskModel> allTasks = [];

  TaskBloc() : super(TaskLoading()) {
    on<GetTasks>((event, emit) {
      emit(TaskLoaded(tasksList: allTasks));
    });
    on<AddTask>((event, emit) {
      emit(TaskLoading());
      allTasks.add(event.task);

      emit(TaskLoaded(tasksList: allTasks));
    });
    on<UpdateTask>((event, emit) {
      emit(TaskLoading());
      TaskModel selectedTask = allTasks.elementAt(event.taskId);
      selectedTask.isCompleted = !selectedTask.isCompleted;

      emit(TaskLoaded(tasksList: allTasks));
    });
    on<RemoveTask>((event, emit) {
      emit(TaskLoading());
      allTasks.removeAt(event.taskId);
      print(allTasks);
      emit(TaskLoaded(tasksList: allTasks));
    });
  }
}
