import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl({required this.remote});

  @override
  Future<User> login({required String email, required String password}) {
    return remote.login(email, password);
  }

  @override
  Future<User> signup({
    required String name,
    required String email,
    required String password,
  }) {
    return remote.signup(name, email, password);
  }

  @override
  Future<User> getCurrentUser() {
    return remote.me();
  }
}
