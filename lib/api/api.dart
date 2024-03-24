import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  Future<http.Response> getWithHeader(String path, {String? token}) async {
    final url = Uri.parse('$baseUrl/$path');
    return await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  Future<http.Response> post(String path, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl/$path');
    return await http.post(url, body: body);
  }

  Future<http.Response> postWithHeader(String path,
      {Map<String, dynamic>? body, String? token}) async {
    final url = Uri.parse('$baseUrl/$path');
    return await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  Future<http.Response> patchWithHeader(String path,
      {Map<String, dynamic>? body, String? token}) async {
    final url = Uri.parse('$baseUrl/$path');
    return await http.patch(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}
