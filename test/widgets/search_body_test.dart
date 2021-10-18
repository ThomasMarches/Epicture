import 'package:epicture/core/presentation/pages/search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchBody', () {
    testWidgets('renders SearchBody', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: SearchBody(),
        ),
      ));
      expect(find.byType(SearchBody), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
