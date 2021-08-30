import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:epicture/core/utils/constants.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/loginpage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final webView = FlutterWebviewPlugin();
  UserEntity? userInformations;
  BuildContext? _context;

  @override
  void initState() {
    super.initState();

    webView.onStateChanged.listen((WebViewStateChanged newState) async {
      var uri = Uri.parse(newState.url.replaceFirst('#', '?'));

      if (uri.query.contains('access_token') == true) {
        await webView.close();
        userInformations = UserEntity(
          accountId: uri.queryParameters['account_id']!,
          accessToken: uri.queryParameters['access_token']!,
          refreshToken: uri.queryParameters['refresh_token']!,
          accountUsername: uri.queryParameters['account_username']!,
        );
        if (_context != null) {
          BlocProvider.of<UserBloc>(_context!)
              .add(FetchUserInformationsEvent(user: userInformations!));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return (state is UserLoadedState)
            ? const HomePage()
            : const WebviewScaffold(
                url: Constants.loginURL,
              );
      },
    );
  }
}
