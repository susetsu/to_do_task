import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_bloc/config/config.dart';
import 'package:todo_list_bloc/infrastructure/models/task.dart';
import 'package:todo_list_bloc/presentation/bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/presentation/screens/task/add_update_task.dart';

class ListTask extends StatelessWidget {
  static const name = 'list-task';
  const ListTask({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocTaskView();
  }
}

class BlocTaskView extends StatelessWidget {
  const BlocTaskView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme().getTheme();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de tareas',
          style: theme.textTheme.displaySmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: const _TaskListBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const AddUpdateTaskScreen());
        },
        child: Icon(
          Icons.add,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}

class _TaskListBuilder extends StatelessWidget {
  const _TaskListBuilder();

  @override
  Widget build(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();
    final theme = AppTheme().getTheme();
    taskBloc.fetchTasks();
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskStateLoading) {
          return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: LinearProgressIndicator());
        } else if (state is TaskStateLoaded && state.tasks.isNotEmpty) {
          final lista = state.tasks;
          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              try {
                final Task task = lista[index];

                return _TaskListView(theme: theme, task: task);
              } on Exception catch (e) {
                debugPrint('$e');
                return const Center(
                  child: Text(
                    "Ocurrió un error mostrando la información, intente nuevamente",
                  ),
                );
              }
            },
          );
        } else if (state is TaskStateError) {
          return const Center(
              child: Text(
                  "Ocurrió un error cargando la información intente nuevamente"));
        } else {
          return const Center(child: Text("No se ha encontrado información"));
        }
      },
    );
  }
}

class _TaskListView extends StatelessWidget {
  const _TaskListView({
    super.key,
    required this.theme,
    required this.task,
  });

  final ThemeData theme;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return FadeInDown(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Card(
              color: theme.colorScheme.surface,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                minVerticalPadding: 15,
                title: Text(
                  task.title,
                  style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color(0xFF654976)),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Inicio: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          TextSpan(
                            text: DateFormat('dd/MM/yy hh:mm a')
                                .format(task.initDate),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (task.endDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Fin: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              TextSpan(
                                text: DateFormat('dd/MM/yy hh:mm a')
                                    .format(task.endDate!),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AddUpdateTaskScreen(
                                  task: task,
                                ));
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Color(0xFF695E93),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<TaskBloc>().deleteTask(task.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Color(0xFF695E93),
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  task.isCompleted ? Icons.check : Icons.schedule,
                  color: task.isCompleted
                      ? const Color(0XFF8155BA)
                      : const Color(0XFFD9A1A0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
