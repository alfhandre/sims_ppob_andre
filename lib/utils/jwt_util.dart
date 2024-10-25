import 'package:jwt_decoder/jwt_decoder.dart';

class JwtUtil {
  static bool isTokenExpired(String token) {
    final bool expired = JwtDecoder.isExpired(token);
    print('Is token expired: $expired'); // Debug log
    return expired;
  }

  static Map<String, dynamic> decodeToken(String token) {
    return JwtDecoder.decode(token);
  }

  static bool isTokenOlderThan(String token, Duration duration) {
    final Map<String, dynamic> decodedToken = decodeToken(token);
    final DateTime issuedAt =
        DateTime.fromMillisecondsSinceEpoch(decodedToken['iat'] * 1000);
    final DateTime now = DateTime.now();
    return now.difference(issuedAt) > duration;
  }
}
