import 'package:flutter/material.dart';
import 'package:very_good_starter/core/presentation/pages/favorite_body.dart';
import 'package:very_good_starter/core/presentation/pages/home_body.dart';
import 'package:very_good_starter/core/presentation/pages/profile_body.dart';
import 'package:very_good_starter/core/presentation/pages/search_body.dart';
import 'package:very_good_starter/core/presentation/pages/upload_body.dart';
import 'package:very_good_starter/core/utils/colors.dart';

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
}
