import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/config/app_theme.dart';
import 'core/router/app_router.dart';
import 'common/providers/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Clean Arch App',
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
