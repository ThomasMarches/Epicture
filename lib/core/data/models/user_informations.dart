class UserInformations {
  UserInformations({
    required this.userName,
    required this.reputation,
    required this.bio,
    required this.reputationName,
    required this.avatar,
    required this.id,
  });

  factory UserInformations.fromMap(Map<String, dynamic> map) {
    return UserInformations(
      userName: map['url'] as String,
      reputation: map['reputation'] as int,
      bio: map['bio'] as String?,
      reputationName: map['reputation_name'] as String,
      avatar: map['avatar'] as String?,
      id: map['id'] as int,
    );
  }

  String userName;
  final int reputation;
  String? bio;
  final String reputationName;
  final String? avatar;
  final int id;
}
