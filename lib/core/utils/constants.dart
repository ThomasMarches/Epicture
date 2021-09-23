import 'package:epicture/core/presentation/pages/favorite_body.dart';
import 'package:epicture/core/presentation/pages/home_body.dart';
import 'package:epicture/core/presentation/pages/profile_body.dart';
import 'package:epicture/core/presentation/pages/search_body.dart';
import 'package:epicture/core/presentation/pages/upload_body.dart';
import 'package:epicture/core/utils/colors.dart';
import 'package:flutter/material.dart';

class Constants {
  static const List<Widget> pages = <Widget>[
    HomeBody(),
    SearchBody(),
    UploadBody(),
    FavoriteBody(),
    ProfileBody(),
  ];

  static const List<Color> epictureTextGradient = [
    EpictureColors.blue,
    EpictureColors.magenta,
    EpictureColors.purple,
    EpictureColors.pink,
    EpictureColors.coral,
  ];

  static const clientId = 'eb62c046c1f70e7';

  static const baseUrl = 'https://api.imgur.com/3';

  static const getUserInformationsURL = '$baseUrl/account/';

  static const uploadImageURL = '$baseUrl/upload/';

  static const getUserImagesURL = '$baseUrl/account/me/images';

  static const generateAccessTokenURL = 'https://api.imgur.com/oauth2/token';

  static const getAccountSettingsURL = '$baseUrl/account/me/settings';

  static const createCommentURL = '$baseUrl/comment/';

  static String commentChangeURL(String commentId) {
    return '$baseUrl/comment/$commentId';
  }

  static String changeAccountSettingsURL(String username) {
    return '$baseUrl/account/$username/settings';
  }

  static String voteOnCommentURL(String commentId, String vote) {
    return '$baseUrl/comment/$commentId/vote/$vote';
  }

  static const getHomePageImages =
      '$baseUrl/gallery/hot/viral/top/1?showViral=true&mature=false&album_previews=false';

  static String getUserFavoriteImagesURL(String username) {
    return '$baseUrl/account/$username/favorites/';
  }

  static String getImageCommentsURL(String imageID) {
    return '$baseUrl/gallery/$imageID/comments/';
  }

  static String searchImagesURL(String? tag) {
    return tag == null
        ? '$baseUrl/gallery/search/'
        : '$baseUrl/gallery/search/time/all/1?q_all=$tag&q_type=jgp&q_type=png';
  }

  static String getFavoriteAnImageURL(String hash) {
    return '$baseUrl/image/$hash/favorite';
  }

  static const loginURL =
      'https://api.imgur.com/oauth2/authorize?client_id=${Constants.clientId}&response_type=token';
}
