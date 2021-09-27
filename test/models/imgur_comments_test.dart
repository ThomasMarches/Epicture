import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Imgur Comments tests', () {
    test('FromMap method test', () {
      final file =
          File('test/ressources/imgur_comments.json').readAsStringSync();

      final comment =
          ImgurComments.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(comment.id, 1110);
      expect(comment.comment, 'This is a Test Caption sent via the API!');
      expect(comment.vote, null);
      expect(comment.ups, 5);
      expect(comment.downs, 0);
      expect(comment.author, 'joshTest');
      expect(
        comment.datetime,
        DateTime.fromMillisecondsSinceEpoch(1346977487 * 1000),
      );
    });
  });
}
