import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../utils/storage_util.dart';
import '../utils/jwt_util.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final AuthService _apiService = AuthService();

  User? get user => _user;

  Future<void> login(String email, String password) async {
    _user = await _apiService.login(email, password);
    if (_user != null) {
      await StorageUtil.saveToken(_user!.token); // Simpan token yang benar
    }
    notifyListeners();
  }

  bool get isAuthenticated {
    return _user != null;
  }

  Future<void> checkToken() async {
    String? token = await StorageUtil.getToken();
    print('Checking token: $token'); // Debug log
    if (token != null) {
      if (JwtUtil.isTokenExpired(token) ||
          JwtUtil.isTokenOlderThan(token, Duration(hours: 12))) {
        print(
            'Token is expired or older than 12 hours, logging out'); // Debug log
        await logout();
      }
    }
  }

  Future<void> logout() async {
    _user = null;
    await StorageUtil.deleteToken();
    notifyListeners();
  }

  void showExpiredSessionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Session Expired'),
        content: Text('Please log in again to continue.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> checkTokenAndRedirect(BuildContext context) async {
    await checkToken();
    if (!isAuthenticated) {
      showExpiredSessionDialog(context);
    }
  }
}
