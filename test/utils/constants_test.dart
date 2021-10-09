import 'package:epicture/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Constants tests', () {
    test('commentChangeURL test', () {
      expect(Constants.commentChangeURL('1234'),
          '${Constants.baseUrl}/comment/1234');
    });
    test('deleteImageURL test', () {
      expect(
          Constants.deleteImageURL('1234'), '${Constants.baseUrl}/image/1234');
    });

    test('changeAccountSettingsURL test', () {
      expect(Constants.changeAccountSettingsURL('Username'),
          '${Constants.baseUrl}/account/Username/settings');
    });

    test('voteOnCommentURL test', () {
      expect(Constants.voteOnCommentURL('1234', 'up'),
          '${Constants.baseUrl}/comment/1234/vote/up');
    });

    test('getUserFavoriteImagesURL test', () {
      expect(Constants.getUserFavoriteImagesURL('Username'),
          '${Constants.baseUrl}/account/Username/favorites/');
    });

    test('getImageCommentsURL test', () {
      expect(Constants.getImageCommentsURL('1234'),
          '${Constants.baseUrl}/gallery/1234/comments/');
    });

    test('searchImagesURL normal test', () {
      expect(Constants.searchImagesURL('dog'),
          '${Constants.baseUrl}/gallery/search/time/all/1?q_all=dog&q_type=jgp&q_type=png');
    });

    test('searchImagesURL test with null tag', () {
      expect(Constants.searchImagesURL(null),
          '${Constants.baseUrl}/gallery/search/');
    });

    test('getFavoriteAnImageURL test', () {
      expect(Constants.getFavoriteAnImageURL('1234'),
          '${Constants.baseUrl}/image/1234/favorite');
    });
  });
}
