import 'dart:convert';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
  Future<UserModel> me();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final res = await client.post(
      ApiEndpoints.login,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final user = UserModel.fromJson(data['data'] ?? data);
      // store token
      client.setToken(user.token);
      return user;
    } else {
      throw Exception('Login failed: ${res.body}');
    }
  }

  @override
  Future<UserModel> signup(String name, String email, String password) async {
    final res = await client.post(
      ApiEndpoints.signup,
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final data = jsonDecode(res.body);
      final user = UserModel.fromJson(data['data'] ?? data);
      client.setToken(user.token);
      return user;
    } else {
      throw Exception('Signup failed: ${res.body}');
    }
  }

  @override
  Future<UserModel> me() async {
    final res = await client.get(
      ApiEndpoints.me,
      auth: true,
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return UserModel.fromJson(data['data'] ?? data);
    } else {
      throw Exception('Fetch current user failed');
    }
  }
}
