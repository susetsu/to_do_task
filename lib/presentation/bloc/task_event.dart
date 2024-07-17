part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class FetchTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String name;
  final DateTime initDate;
  final DateTime? endDate;
  final bool isCompleted;

  const AddTask(this.name, this.initDate, this.endDate, this.isCompleted);

  @override
  List<Object> get props => [name];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}
