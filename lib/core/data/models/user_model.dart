import 'dart:convert';

class UserModel {
  UserModel(
    this.userName,
    this.clientId,
    this.biography,
    this.avatarName,
    this.avatarPath,
    this.refreshToken,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['userName'],
      map['clientId'],
      map['biography'],
      map['avatarName'],
      map['avatarPath'],
      map['refreshToken'],
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'clientId': clientId,
      'biography': biography,
      'avatarName': avatarName,
      'avatarPath': avatarPath,
      'refreshToken': refreshToken,
    };
  }

  String toJson() => json.encode(toMap());

  final String userName;
  final String clientId;
  final String biography;
  final String avatarName;
  final String avatarPath;
  final String refreshToken;
}
