import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/user_informations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Imgur Images tests', () {
    test('FromMap method test', () {
      final file =
          File('test/ressources/user_informations.json').readAsStringSync();

      final userInformations =
          UserInformations.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(userInformations.userName, 'ghostinspector');
      expect(userInformations.reputation, 15303);
      expect(userInformations.bio,
          'A real hoopy frood who really knows where his towel is at.');
      expect(userInformations.reputationName, 'Neutral');
      expect(userInformations.avatar, null);
      expect(userInformations.id, 48437714);
    });
  });
}
