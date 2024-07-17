import 'package:todo_list_bloc/infrastructure/models/task.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class TaskServices {
  static List<Task> get _initTasks {
    return [
      Task(
          id: uuid.v4(),
          title: 'Planificar app movil',
          initDate: DateTime.now()),
      Task(
          id: uuid.v4(),
          title: 'Desarrollar app movil',
          initDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          isCompleted: true),
      Task(
          id: uuid.v4(), title: 'Publicar app movil', initDate: DateTime.now()),
    ];
  }

  Future< List<Task>> getTask() async {
    await Future.delayed(const Duration(seconds: 1));
    return _initTasks;
  }
}
