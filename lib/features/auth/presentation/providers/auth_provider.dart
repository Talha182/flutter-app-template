import 'package:flutter/foundation.dart';

import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider({required this.repository});

  AuthStatus _status = AuthStatus.initial;
  AuthStatus get status => _status;

  User? _user;
  User? get user => _user;

  String? _error;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final user = await repository.login(email: email, password: password);
      _user = user;
      _status = AuthStatus.authenticated;
      _error = null;
    } catch (e) {
      _status = AuthStatus.error;
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> signup(String name, String email, String password) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final user = await repository.signup(
        name: name,
        email: email,
        password: password,
      );
      _user = user;
      _status = AuthStatus.authenticated;
      _error = null;
    } catch (e) {
      _status = AuthStatus.error;
      _error = e.toString();
    }
    notifyListeners();
  }

  void logout() {
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
