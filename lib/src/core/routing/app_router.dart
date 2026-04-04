import 'package:admin_msar/src/features/posts/views/posts_page.dart';
import 'package:admin_msar/src/features/users/users_page.dart';
import 'package:go_router/go_router.dart';
import 'package:admin_msar/src/core/storage/token_storage.dart';
import 'package:admin_msar/src/features/add_post/add_post_page.dart';
import 'package:admin_msar/src/features/auth/login/views/login_page.dart';
import 'package:admin_msar/src/features/home/views/home_page.dart';

class AppRouter {
  AppRouter(this.storage);
  final TokenStorage storage;

  late final GoRouter router = GoRouter(
    // navigatorKey: AppOverlay.navigatorKey,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (_, __) => const NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (_, __) => const NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: '/add_post',
        name: 'add_post',
        pageBuilder: (_, __) => const NoTransitionPage(child: AddPostPage()),
      ),
      GoRoute(
        path: '/users',
        name: 'users',
        pageBuilder: (_, __) => const NoTransitionPage(child: UsersPage()),
      ),
      GoRoute(
        path: '/posts',
        name: 'posts',
        pageBuilder: (_, __) => const NoTransitionPage(child: PostsPage()),
      ),
      //   ],
      //   redirect: (context, state) async {
      //     final user = await UserBox().readUser();
      //     final logged = user != null;

      //     final seenOnboarding = await storage.getOnboardingSeen();

      //     final location = state.matchedLocation;

      //     const publicRoutes = <String>{
      //       '/onboarding',
      //       '/login',
      //       '/register',
      //       '/register_map',
      //       '/reset-password',
      //       '/verify',
      //       '/verify_account',
      //       '/new-password',
      //       '/support',
      //     };

      //     if (!logged && !seenOnboarding && location != '/onboarding') {
      //       return '/onboarding';
      //     }

      //     if (logged &&
      //         (location == '/login' ||
      //             location == '/onboarding' ||
      //             location == '/register')) {
      //       return '/';
      //     }

      //     if (!logged && !publicRoutes.contains(location)) {
      //       return '/login';
      //     }

      //     return null;
      //   },
      // );
    ],
  );
}
