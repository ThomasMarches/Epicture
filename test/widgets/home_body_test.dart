import 'package:epicture/core/presentation/pages/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBody', () {
    testWidgets('renders HomeBody', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: HomeBody(),
        ),
      ));
      expect(find.byType(HomeBody), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
