import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Imgur Images tests', () {
    test('FromMap method test', () {
      final file = File('test/ressources/imgur_images.json').readAsStringSync();

      final comment =
          ImgurImages.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(comment.id, 'SbBGk');
      expect(comment.title, null);
      expect(comment.description, null);
      expect(comment.vote, null);
      expect(comment.width, 2559);
      expect(comment.height, 1439);
      expect(comment.type, 'jpeg');
      expect(comment.favorite, false);
      expect(comment.link, 'http://i.imgur.com/SbBGk.jpg');
      expect(comment.section, null);
      expect(
        comment.datetime,
        DateTime.fromMillisecondsSinceEpoch(1341533193 * 1000),
      );
    });
  });
}
