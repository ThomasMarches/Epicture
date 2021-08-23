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
      clientId: map['clientId'],
      biography: map['biography'],
      avatarName: map['avatarName'],
      avatarPath: map['avatarPath'],
      accessToken: map['accessToken'],
      accountUsername: map['accountUsername'],
      accountId: map['accountId'],
      refreshToken: map['refreshToken'],
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
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
