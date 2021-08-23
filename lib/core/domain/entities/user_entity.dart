import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.accountId,
    required this.accountUsername,
  });

  final String accessToken;
  final String refreshToken;
  final String accountUsername;
  final String accountId;

  @override
  List<Object> get props => [
        accessToken,
        refreshToken,
        accountUsername,
        accountId,
      ];
}
