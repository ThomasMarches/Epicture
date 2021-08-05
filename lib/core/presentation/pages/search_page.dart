import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/searchpage';

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
