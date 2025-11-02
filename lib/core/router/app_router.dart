import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/details/presentation/pages/details_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../routes/route_paths.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RoutePaths.login, // start from login
    routes: [
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RoutePaths.details,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return DetailsPage(
            title: extra?['title'] ?? 'Details',
            message: extra?['message'] ?? 'No message passed.',
          );
        },
      ),
    ],
  );
}
