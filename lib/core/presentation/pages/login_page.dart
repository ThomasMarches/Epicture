import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/core/presentation/pages/home_page.dart';
import 'package:epicture/core/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/loginpage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isUserLoggedIn = false;
  final webView = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    webView.onStateChanged.listen((WebViewStateChanged newState) async {
      var uri = Uri.parse(newState.url.replaceFirst('#', '?'));

      if (uri.query.contains('access_token') == true) {
        await webView.close();

        final preferences = await SharedPreferences.getInstance();
        await preferences.setString(
          'access_token',
          uri.queryParameters.containsKey('access_token')
              ? uri.queryParameters['access_token']!
              : '',
        );
        await preferences.setString(
          'refresh_token',
          uri.queryParameters.containsKey('refresh_token')
              ? uri.queryParameters['refresh_token']!
              : '',
        );
        await preferences.setString(
          'account_username',
          uri.queryParameters.containsKey('account_username')
              ? uri.queryParameters['account_username']!
              : '',
        );
        await preferences.setString(
          'account_id',
          uri.queryParameters.containsKey('account_id')
              ? uri.queryParameters['account_id']!
              : '',
        );

        setState(() {
          isUserLoggedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isUserLoggedIn
        ? const WebviewScaffold(
            url: Constants.loginURL,
          )
        : const HomePage();
  }
}
