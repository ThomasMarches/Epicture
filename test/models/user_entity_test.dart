import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEntity tests', () {
    const user = UserEntity(
      accountId: 'accountId',
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      accountUsername: 'Username',
    );

    const anotherUser = UserEntity(
      accountId: 'accountId',
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      accountUsername: 'Username',
    );

    const lastUser = UserEntity(
      accountId: 'accountId',
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      accountUsername: 'AnotherName',
    );
    test('Constructor test', () {
      expect(user.accountId, 'accountId');
      expect(user.accessToken, 'accessToken');
      expect(user.refreshToken, 'refreshToken');
      expect(user.accountUsername, 'Username');
    });
    test('Equatability test', () {
      expect(user == anotherUser, true);
      expect(user == lastUser, false);
    });
  });
}
