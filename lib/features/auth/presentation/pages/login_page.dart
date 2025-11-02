import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../routes/route_paths.dart';
import '../../presentation/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Login', style: textTheme.titleLarge)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (v) => _email = v!.trim(),
                validator: (v) =>
                v == null || v.isEmpty ? 'Enter email' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (v) => _password = v!.trim(),
                validator: (v) =>
                v == null || v.isEmpty ? 'Enter password' : null,
              ),
              const SizedBox(height: 24),
              if (auth.status == AuthStatus.loading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      await auth.login(_email, _password);
                      if (mounted && auth.status == AuthStatus.authenticated) {
                        context.go(RoutePaths.home);
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.push(RoutePaths.signup),
                child: const Text("Don't have an account? Sign up"),
              ),
              if (auth.status == AuthStatus.error)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    auth.error ?? 'Login failed',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
