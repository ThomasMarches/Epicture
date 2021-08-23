import 'package:flutter/material.dart';
import 'package:epicture/core/presentation/pages/favorite_body.dart';
import 'package:epicture/core/presentation/pages/login_page.dart';
import 'package:epicture/core/presentation/pages/search_body.dart';
import 'package:epicture/core/presentation/pages/upload_body.dart';

import '../pages/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    // switch (routeSettings.name) {
    //   case HomePage.routeName:
    //     return MaterialPageRoute(builder: (_) => const HomePage());
    //   case LoginPage.routeName:
    return MaterialPageRoute(builder: (_) => const LoginPage());
    //   case FavoriteBody.routeName:
    //     return MaterialPageRoute(builder: (_) => const FavoriteBody());
    //   case UploadBody.routeName:
    //     return MaterialPageRoute(builder: (_) => const UploadBody());
    //   case SearchBody.routeName:
    //     return MaterialPageRoute(builder: (_) => const SearchBody());
    //   default:
    //     return null;
    // }
  }
}
