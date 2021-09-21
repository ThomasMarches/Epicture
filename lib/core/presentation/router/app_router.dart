import 'package:epicture/core/presentation/pages/image_page.dart';
import 'package:epicture/core/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == ImagePage.routeName) {
      final arg = routeSettings.arguments as ImagePageArguments;
      return MaterialPageRoute(builder: (_) => ImagePage(image: arg));
    }
    return MaterialPageRoute<LoginPage>(builder: (_) => const LoginPage());
  }
}
