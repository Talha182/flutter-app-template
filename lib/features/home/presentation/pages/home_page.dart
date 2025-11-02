import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../common/providers/theme_provider.dart';
import '../../../../../routes/route_paths.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: const Icon(Icons.brightness_6),
          ),
          // inside actions
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.go(RoutePaths.login);
            },
            icon: const Icon(Icons.logout),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome 👋', style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'GoRouter + Provider + Clean structure + Two fonts.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push(
                  RoutePaths.details,
                  extra: {
                    'title': 'User Profile',
                    'message': 'This is passed via go_router extra.',
                  },
                );
              },
              child: Text(
                'Go to Details',
                style: textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
