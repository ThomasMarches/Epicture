import 'package:epicture/core/presentation/router/app_router.dart';
import 'package:epicture/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final ThemeData theme = ThemeData();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme:
            theme.colorScheme.copyWith(secondary: const Color(0xFF13B9FF)),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}
