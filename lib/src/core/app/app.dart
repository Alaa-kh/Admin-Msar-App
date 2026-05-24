import 'package:admin_msar/src/core/di/injector.dart';
import 'package:admin_msar/src/core/routing/app_router.dart';
import 'package:admin_msar/src/core/storage/token_storage.dart';
import 'package:admin_msar/src/core/theme/app_theme.dart';
import 'package:admin_msar/src/features/auth/session/presentation/cubit/auth_session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMsarApp extends StatefulWidget {
  const AdminMsarApp({super.key});

  @override
  State<AdminMsarApp> createState() => _AdminMsarAppState();
}

class _AdminMsarAppState extends State<AdminMsarApp> {
  late final AuthSessionCubit _session;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _session = getIt<AuthSessionCubit>();
    _appRouter = AppRouter(
      storage: TokenStorage(),
      sessionCubit: _session,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _session,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'msar_app',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        locale: const Locale('ar'),
        builder: (context, child) {
          if (child == null) return const SizedBox.shrink();
          return Directionality(textDirection: TextDirection.rtl, child: child);
        },
        routerConfig: _appRouter.router,
      ),
    );
  }
}
