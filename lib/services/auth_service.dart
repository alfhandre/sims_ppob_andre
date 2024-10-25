import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../url.dart';
import '../exception/auth_exception.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../utils/storage_util.dart';

class AuthService {
  final Url urlProvider = Url();

  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${urlProvider.getVal()}login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      final String? token = jsonResponse['data']['token'];

      if (token == null) {
        throw AuthException('Token tidak ditemukan');
      }

      if (JwtDecoder.isExpired(token)) {
        throw Exception('Token telah expired');
      }

      await StorageUtil.saveToken(token);
      return User(token: token);
    } else {
      throw AuthException(jsonResponse['message'] ?? 'An error occurred');
    }
  }
}
