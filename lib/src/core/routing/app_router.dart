import 'dart:async';

import 'package:admin_msar/src/features/add_ads/views/add_ads_page.dart';
import 'package:admin_msar/src/features/ads/views/ads_page.dart';
import 'package:admin_msar/src/features/auth/session/presentation/cubit/auth_session_cubit.dart';
import 'package:admin_msar/src/features/auth/session/presentation/cubit/auth_session_state.dart';
import 'package:admin_msar/src/features/posts/views/posts_page.dart';
import 'package:admin_msar/src/features/users/users_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:admin_msar/src/core/storage/token_storage.dart';
import 'package:admin_msar/src/features/add_post/add_post_page.dart';
import 'package:admin_msar/src/features/auth/login/views/login_page.dart';
import 'package:admin_msar/src/features/home/views/home_page.dart';

class AppRouter {
  AppRouter({required this.storage, required this.sessionCubit});
  final TokenStorage storage;
  final AuthSessionCubit sessionCubit;

  late final GoRouter router = GoRouter(
    initialLocation: '/home',
    refreshListenable: _CubitRefresh(sessionCubit),
    redirect: (context, state) {
      final session = sessionCubit.state;
      final location = state.matchedLocation;

      if (session is AuthSessionInitial) return null;

      final isAuthed = session is AuthSessionAuthenticated;
      final isLoginPage = location == '/login';

      if (!isAuthed && !isLoginPage) return '/login';
      if (isAuthed && isLoginPage) return '/home';
      return null;
    },
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
      GoRoute(
        path: '/ads',
        name: 'ads',
        pageBuilder: (_, __) => const NoTransitionPage(child: AdsPage()),
      ),
      GoRoute(
        path: '/add_ads',
        name: 'add_ads',
        pageBuilder: (_, __) => const NoTransitionPage(child: AddAdsPage()),
      ),
    ],
  );
}

class _CubitRefresh extends ChangeNotifier {
  _CubitRefresh(AuthSessionCubit cubit) {
    notifyListeners();
    _subscription = cubit.stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
