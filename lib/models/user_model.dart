class UserData {
  final int status;
  final String message;
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;

  UserData({
    required this.status,
    required this.message,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json['status'],
      message: json['message'],
      email: json['data']['email'],
      firstName: json['data']['first_name'],
      lastName: json['data']['last_name'],
      profileImage: json['data']['profile_image'],
    );
  }
}

class TokenModel {
  final String token;

  TokenModel({required this.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['data']['token'],
    );
  }
}
