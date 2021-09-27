import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Model tests', () {
    test('FromMap method test', () {
      final file =
          File('test/ressources/imgur_comments.json').readAsStringSync();

      final comment =
          ImgurComments.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(comment.comment, 'This is a Test Caption sent via the API!');
    });
  });
}
