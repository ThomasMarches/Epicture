import 'package:flutter/material.dart';
import 'package:very_good_starter/core/presentation/pages/favorite_page.dart';
import 'package:very_good_starter/core/presentation/pages/login_page.dart';
import 'package:very_good_starter/core/presentation/pages/search_page.dart';
import 'package:very_good_starter/core/presentation/pages/upload_page.dart';

import '../pages/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case FavoritePage.routeName:
        return MaterialPageRoute(builder: (_) => const FavoritePage());
      case UploadPage.routeName:
        return MaterialPageRoute(builder: (_) => const UploadPage());
      case SearchPage.routeName:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      default:
        return null;
    }
  }
}
