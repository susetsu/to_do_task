part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskStateLoaded extends TaskState {
  final List<Task> tasks;

  const TaskStateLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
  TaskStateLoaded copyWith({
    List<Task>? tasks,
  }) =>
      TaskStateLoaded(
        tasks ?? this.tasks,
      );
}

class TaskStateError extends TaskState {
  final String message;

  const TaskStateError(this.message);

  @override
  List<Object> get props => [message];

  TaskStateError copyWith({String? message}) {
    return TaskStateError(
      message ?? this.message,
    );
  }
}

class TaskStateLoading extends TaskState {
  const TaskStateLoading();
}
