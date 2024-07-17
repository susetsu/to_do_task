import 'package:go_router/go_router.dart';
import 'package:todo_list_bloc/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: ListTask.name,
    builder: (context, state) => const ListTask(),
        routes: [
          GoRoute(
            path: 'task/add',
            name: AddUpdateTaskScreen.name,
            builder: (context, state) => const AddUpdateTaskScreen(),
          ),
    //       GoRoute(
    //         path: '/task/delete',
    //         name: DeleteTask.name,
    //         builder: (context, state) => const DeleteTask(),
    //       ),
    //       GoRoute(
    //         path: '/task/update',
    //         name: UpdateTask.name,
    //         builder: (context, state) => const UpdateTask(),
    //       ),
    ]
  ),
]);
