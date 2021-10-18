import 'package:epicture/core/presentation/pages/upload_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UploadBody', () {
    testWidgets('renders UploadBody', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: UploadBody(),
        ),
      ));
      expect(find.byType(UploadBody), findsOneWidget);
    });
  });
}
