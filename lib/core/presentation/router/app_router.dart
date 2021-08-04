import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return null;
    }
  }
}
