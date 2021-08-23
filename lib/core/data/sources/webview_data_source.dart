import 'package:epicture/core/data/models/user_model.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewDataSource {
  static Future<UserModel?> fetchUserInformations() async {
    final webView = FlutterWebviewPlugin();
    UserModel? userInformations;

    webView.onStateChanged.listen((WebViewStateChanged newState) async {
      var uri = Uri.parse(newState.url.replaceFirst('#', '?'));

      if (uri.query.contains('access_token') == true) {
        await webView.close();
        userInformations = UserModel(
          accountId: uri.queryParameters['access_token']!,
          accessToken: uri.queryParameters['refresh_token']!,
          refreshToken: uri.queryParameters['account_username']!,
          accountUsername: uri.queryParameters['account_id']!,
        );
      }
    });

    // ! TO DO
    // * check why userInformations is null on retun ( async ? )
    return (userInformations == null) ? null : userInformations;
  }
}
