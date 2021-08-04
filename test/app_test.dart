import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_starter/core/presentation/app/app.dart';
import 'package:very_good_starter/core/presentation/pages/home_page.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
