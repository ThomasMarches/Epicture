import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
  }) : super(key: key);

  static const routeName = '/searchpage';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return const Text('Profile Body');
  }
}
