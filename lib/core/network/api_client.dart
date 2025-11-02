import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;
  String? _token;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  void setToken(String? token) {
    _token = token;
  }

  Map<String, String> _headers({bool auth = false}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (auth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<http.Response> post(
      String url, {
        Map<String, dynamic>? body,
        bool auth = false,
      }) async {
    return _client.post(
      Uri.parse(url),
      headers: _headers(auth: auth),
      body: jsonEncode(body ?? {}),
    );
  }

  Future<http.Response> get(
      String url, {
        bool auth = false,
      }) async {
    return _client.get(
      Uri.parse(url),
      headers: _headers(auth: auth),
    );
  }
}
