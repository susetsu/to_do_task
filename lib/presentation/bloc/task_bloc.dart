import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_bloc/infrastructure/models/task.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_list_bloc/infrastructure/services/task.dart';

part 'task_event.dart';
part 'task_state.dart';

const uuid = Uuid();

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskStateLoading()) {
    on<FetchTasks>(_getTasks);
    on<AddTask>(_addTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void addTask(String name, DateTime initDate, DateTime? endDate, [bool isCompleted = false]) {
    add(AddTask(name, initDate, endDate, isCompleted));
  }

  void _addTask(AddTask event, Emitter<TaskState> emit) {
    final newTask = Task(
      id: uuid.v4(),
      title: event.name,
      initDate: event.initDate,
      isCompleted: event.isCompleted,
      endDate: event.endDate,
    );

    if (state is TaskStateLoaded) {
      final loadedState = state as TaskStateLoaded;
      emit(loadedState.copyWith(tasks: [...loadedState.tasks, newTask]));
    }
  }
  void fetchTasks() {
    add(FetchTasks());
  }
  Future<void> _getTasks(FetchTasks event, Emitter<TaskState> emit) async {
    try {
      emit(const TaskStateLoading());
      final tasks = await TaskServices().getTask();
      emit(TaskStateLoaded(tasks));
    } catch (e) {
      emit(const TaskStateError('Failed to fetch tasks'));
    }
  }

  void updateTask(Task task) {
    add(UpdateTask(task));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    if (state is TaskStateLoaded) {
      final loadedState = state as TaskStateLoaded;
      final updatedTasks = loadedState.tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      emit(loadedState.copyWith(tasks: updatedTasks));
    }
  }

  void deleteTask(String id) {
    add(DeleteTask(id));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    if (state is TaskStateLoaded) {
      final loadedState = state as TaskStateLoaded;
      final updatedTasks = loadedState.tasks.where((task) => task.id != event.taskId).toList();
      emit(loadedState.copyWith(tasks: updatedTasks));
    }
  }
}
