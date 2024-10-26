import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../utils/storage_util.dart';
import '../utils/jwt_util.dart';

class AuthProvider with ChangeNotifier {
  TokenModel? _token;
  UserData? _user;
  final AuthService _apiService = AuthService();

  TokenModel? get token => _token;
  UserData? get user => _user;

  Future<void> login(String email, String password) async {
    _token = await _apiService.login(email, password);
    if (_token != null) {
      await StorageUtil.saveToken(_token!.token);
    }
    notifyListeners();
  }

  Future<void> fetchAccount() async {
    _user = await _apiService.fetchAccount();
    notifyListeners();
  }

  bool get isAuthenticated {
    return _token != null;
  }

  Future<void> checkToken() async {
    String? token = await StorageUtil.getToken();
    print('Checking token: $token');
    if (token != null) {
      if (JwtUtil.isTokenExpired(token) ||
          JwtUtil.isTokenOlderThan(token, Duration(hours: 12))) {
        print('Token is expired or older than 12 hours, logging out');
        await logout();
      }
    }
  }

  Future<void> logout() async {
    _token = null;
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
