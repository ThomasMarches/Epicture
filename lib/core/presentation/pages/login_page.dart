import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/loginpage';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homePageTitle),
      ),
      body: Center(
        child: Text(l10n.homePageText),
      ),
    );
  }
}
