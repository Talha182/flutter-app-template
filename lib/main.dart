import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'common/providers/theme_provider.dart';
import 'core/di/injection_container.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'core/config/size_config.dart'; // ✅ Import SizeConfig

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize all dependencies
  await initDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(repository: sl<AuthRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
