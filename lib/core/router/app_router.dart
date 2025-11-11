import 'package:go_router/go_router.dart';
import 'package:sports_app/features/tasks/presentation/pages/tasks_page.dart';
import '../../routes/route_paths.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RoutePaths.tasksPage, // start from login
    routes: [
      GoRoute(
        path: RoutePaths.tasksPage,
        builder: (context, state) => TaskPage(),
      ),

    ],
  );
}
