import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Imgur Post tests', () {
    test('FromMap method test with normal post', () {
      final file = File('test/ressources/imgur_post.json').readAsStringSync();

      final post = ImgurPost.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(post.id, 'SbBGk');
      expect(post.title, null);
      expect(post.description, null);
      expect(post.author, "TestName");
      expect(post.isAlbum, false);
      expect(post.vote, null);
      expect(post.type, 'jpeg');
      expect(post.favorite, false);
      expect(post.link, 'http://i.imgur.com/SbBGk.jpg');
      expect(
        post.datetime,
        DateTime.fromMillisecondsSinceEpoch(1341533193 * 1000),
      );
    });

    test('FromMap method test with gallery post', () {
      final file =
          File('test/ressources/imgur_gallery_posts.json').readAsStringSync();

      final post = ImgurPost.fromMap(jsonDecode(file) as Map<String, dynamic>);

      expect(post.id, 'IbodQnK');
      expect(post.title,
          'A wooden map of Ocean City, Maryland I made as a commission.');
      expect(post.description, 'Just a simple description');
      expect(post.author, 'Inzitarie');
      expect(post.vote, '');
      expect(post.isAlbum, true);
      expect(post.type, null);
      expect(post.favorite, true);
      expect(post.link, 'https://i.imgur.com/KM5rgMA.jpeg');
      expect(
        post.datetime,
        DateTime.fromMillisecondsSinceEpoch(1630381071 * 1000),
      );
    });
  });
}
