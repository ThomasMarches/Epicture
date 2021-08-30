import 'package:flutter/material.dart';
import 'package:epicture/core/presentation/pages/favorite_body.dart';
import 'package:epicture/core/presentation/pages/home_body.dart';
import 'package:epicture/core/presentation/pages/profile_body.dart';
import 'package:epicture/core/presentation/pages/search_body.dart';
import 'package:epicture/core/presentation/pages/upload_body.dart';
import 'package:epicture/core/utils/colors.dart';

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

  static const clientId = '8e9c6eeae958099';

  // * https://api.imgur.com/models/account
  // ! add the username after the /account/
  static const getUserInformationsURL = 'https://api.imgur.com/3/account/';

  static const getUserImagesURL = 'https://api.imgur.com/3/account/me/images';

  // * https://apidocs.imgur.com/#3f80c836-8f49-4fb1-95a7-a4b058265d72
  static const generateAccessTokenURL = 'https://api.imgur.com/oauth2/token';

  // * https://apidocs.imgur.com/#ce57e346-3515-4381-a772-ef5ade60bdee
  static const getAccountSettingsURL =
      'https://api.imgur.com/3/account/me/settings';

  // * https://apidocs.imgur.com/#ce57e346-3515-4381-a772-ef5ade60bdee
  static String changeAccountSettingsURL(String username) {
    return 'https://api.imgur.com/3/account/$username/settings';
  }

  static const loginURL =
      'https://api.imgur.com/oauth2/authorize?client_id=8e9c6eeae958099&response_type=token';
}
