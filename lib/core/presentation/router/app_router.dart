import 'package:epicture/core/presentation/pages/preview_page.dart';
import 'package:epicture/core/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == PreviewPage.routeName) {
      final arg = routeSettings.arguments as PreviewPageArguments;
      return MaterialPageRoute(builder: (_) => PreviewPage(arguments: arg));
    }
    return MaterialPageRoute<LoginPage>(builder: (_) => const LoginPage());
  }
}
