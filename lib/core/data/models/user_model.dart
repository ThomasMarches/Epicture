import 'dart:convert';

class UserModel {
  UserModel({
    required this.accessToken,
    required this.refreshToken,
    required this.accountId,
    required this.accountUsername,
    this.clientId = '',
    this.biography = '',
    this.avatarName = '',
    this.avatarPath = '',
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      clientId: map['clientId'] as String,
      biography: map['biography'] as String,
      avatarName: map['avatarName'] as String,
      avatarPath: map['avatarPath'] as String,
      accessToken: map['accessToken'] as String,
      accountUsername: map['accountUsername'] as String,
      accountId: map['accountId'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  factory UserModel.fromJson(String source) {
      return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'clientId': clientId,
      'biography': biography,
      'avatarName': avatarName,
      'avatarPath': avatarPath,
      'refreshToken': refreshToken,
      'accessToken': accessToken,
      'accountId': accountId,
      'accountUsername': accountUsername
    };
  }

  String toJson() => json.encode(toMap());

  late String clientId;
  late String biography;
  late String avatarName;
  late String avatarPath;

  final String accessToken;
  final String refreshToken;
  final String accountUsername;
  final String accountId;
}
