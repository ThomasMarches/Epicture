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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(const FetchUserInformationsEvent());

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return (state is UserLoadedState)
            ? const WebviewScaffold(
                url: Constants.loginURL,
              )
            : const HomePage();
      },
    );
  }
}
