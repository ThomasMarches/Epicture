import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class UploadBody extends StatelessWidget {
  const UploadBody({
    Key? key,
  }) : super(key: key);

  static const routeName = '/uploadpage';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return const Text('Upload Body');
  }
}
