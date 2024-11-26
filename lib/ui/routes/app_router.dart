import 'package:go_router/go_router.dart';
import 'package:pushchino_app/ui/pages/login_page.dart';
import 'package:pushchino_app/ui/pages/main_page.dart';

abstract class AppRouter {
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: '/main',
            builder: (context, state) => const MainPage(),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
