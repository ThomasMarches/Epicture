import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

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
