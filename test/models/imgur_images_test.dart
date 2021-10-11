import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Imgur Images tests', () {
    test('FromMap method test with normal image', () {
      final file = File('test/ressources/imgur_images.json').readAsStringSync();

      final image =
          ImgurImages.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(image.id, 'SbBGk');
      expect(image.title, null);
      expect(image.description, null);
      expect(image.author, "TestName");
      expect(image.vote, null);
      expect(image.width, 2559);
      expect(image.height, 1439);
      expect(image.type, 'jpeg');
      expect(image.favorite, false);
      expect(image.link, 'http://i.imgur.com/SbBGk.jpg');
      expect(
        image.datetime,
        DateTime.fromMillisecondsSinceEpoch(1341533193 * 1000),
      );
    });

    test('FromMap method test with gallery image', () {
      final file =
          File('test/ressources/imgur_gallery_images.json').readAsStringSync();

      final image =
          ImgurImages.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(image.id, 'IbodQnK');
      expect(image.title,
          'A wooden map of Ocean City, Maryland I made as a commission.');
      expect(image.description, 'Just a simple description');
      expect(image.author, 'Inzitarie');
      expect(image.vote, '');
      expect(image.width, 3024);
      expect(image.height, 4032);
      expect(image.type, 'jpeg');
      expect(image.favorite, true);
      expect(image.link, 'https://i.imgur.com/KM5rgMA.jpeg');
      expect(
        image.datetime,
        DateTime.fromMillisecondsSinceEpoch(1630381071 * 1000),
      );
    });
  });
}
