import 'package:epicture/core/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('Utils tests', () {
    test('getTimeDifference test with Days difference', () {
      expect(
          Utils.getTimeDifference(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
          '7 days ago');
    });

    test('getTimeDifference test with hours difference', () {
      expect(
          Utils.getTimeDifference(
            DateTime.now().subtract(
              const Duration(hours: 10),
            ),
          ),
          '10 hours ago');
    });

    test('getTimeDifference test with minutes difference', () {
      expect(
          Utils.getTimeDifference(
            DateTime.now().subtract(
              const Duration(minutes: 30),
            ),
          ),
          '30 minutes ago');
    });

    test('getTimeDifference test with long difference', () {
      expect(
        Utils.getTimeDifference(DateTime.now().subtract(
          const Duration(days: 60),
        )),
        DateFormat.yMMMEd().format(
          DateTime.now().subtract(
            const Duration(days: 60),
          ),
        ),
      );
    });
  });
}
