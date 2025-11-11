import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'common/providers/theme_provider.dart';
import 'core/di/injection_container.dart';
import 'features/tasks/presentation/providers/task_provider.dart';
import 'features/tasks/domain/repositories/task_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependency injection
  await initDependencies();
  // Run the app with ScreenUtil and MultiProvider
  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844), // Base design size from Figma
      minTextAdapt: true,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<TaskProvider>(
            create: (_) => TaskProvider(sl<TasksRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
