import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/routing/app_router.dart';
import 'package:admin_msar/src/core/storage/token_storage.dart';
import 'package:admin_msar/src/core/theme/app_theme.dart';

class AdminMsarApp extends StatelessWidget {
  const AdminMsarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = TokenStorage();
    final router = AppRouter(storage).router;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'msar_app',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      locale: const Locale('ar'),
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();
        return Directionality(textDirection: TextDirection.rtl, child: child);
      },

      routerConfig: router,
    );
  }
}
