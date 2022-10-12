import 'package:equatable/equatable.dart';
import 'package:todoapp/blocs/bloc_exports.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/blocs/tasks/models/task.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/mappers/task_mapper.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper db;
  final CategoryBloc categoryBloc;
  int tasksNumbers = 0;

  DateTime now = DateTime.now();
  late DateTime selectedTaskDate = DateTime(now.year, now.month, now.day);

  TaskBloc({required this.db, required this.categoryBloc})
      : super(TasksLoading()) {
    on<GetTasks>(_onGetTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<RemoveTasksWithCategory>(_onRemoveTasksWithCategory);
    on<SetTaskDate>(_onSetTaskDate);
  }

  Future<void> _onGetTasks(GetTasks event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    String? category = categoryBloc.selectedCategory;

    List<Task> allTasks = await db.getTasks();

    if (event.changeToBaseCategory) {
      category = Constants.baseCategoryName;
    }

    if (category == Constants.baseCategoryName) {
      List<Task> tasksByDate = allTasks
          .where((element) => element.date == selectedTaskDate.toString())
          .toList();

      List<Task> allTasksListByDate = _fetchTasks(tasksByDate);
      if (allTasksListByDate.isEmpty) {
        emit(TasksEmpty());
        return;
      }
      emit(TasksLoaded(tasksList: allTasksListByDate.mapToListTaskModel()));
    } else {
      List<Task> tasksByCategory = allTasks
          .where((element) =>
              element.category == category &&
              element.date == selectedTaskDate.toString())
          .toList();
      List<Task> allTasksListByCategory = _fetchTasks(tasksByCategory);
      if (allTasksListByCategory.isEmpty) {
        emit(TasksEmpty());
        return;
      }
      emit(TasksLoaded(tasksList: allTasksListByCategory.mapToListTaskModel()));
    }
  }

  List<Task> _fetchTasks(List<Task> list) {
    List<Task> completedTasks =
        list.where((element) => element.isCompleted == 1).toList();
    List<Task> uncompletedTasks =
        list.where((element) => element.isCompleted == 0).toList();

    List<Task> tasksList = [...uncompletedTasks, ...completedTasks];

    tasksNumbers = tasksList.length;

    return tasksList;
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(TasksLoading());

    final TaskModel task = TaskModel(
      isCompleted: false,
      taskName: event.taskName,
      category: categoryBloc.selectedCategoryInModal,
      date: selectedTaskDate,
    );

    await db.insertTask(task.mapToTask());

    add(const GetTasks(changeToBaseCategory: true));
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    TaskModel updatedTask =
        event.task.copyWith(isCompleted: !event.task.isCompleted);
    Task task = updatedTask.mapToTask();

    await db.updateTask(task);

    add(const GetTasks());
  }

  Future<void> _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    await db.deleteTask(event.taskId);

    add(const GetTasks());
  }

  Future<void> _onRemoveTasksWithCategory(
      RemoveTasksWithCategory event, Emitter<TaskState> emit) async {
    await db.deleteTasksByCategory(event.selectedCategory);

    categoryBloc.add(RemoveCategory(category: event.selectedCategory));
    add(const GetTasks(changeToBaseCategory: true));
  }

  Future<void> _onSetTaskDate(
      SetTaskDate event, Emitter<TaskState> emit) async {
    selectedTaskDate = event.date;
  }
}
