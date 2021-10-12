import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/profile_gallery_bloc/profile_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/home_page.dart';
import 'package:epicture/core/presentation/pages/image_page.dart';
import 'package:epicture/core/presentation/router/app_router.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

final image = ImgurImages(
  id: 'CiTPwEY',
  author: null,
  type: 'jpeg',
  width: 480,
  height: 360,
  vote: 'up',
  favorite: true,
  title: 'TestTitle',
  description: 'A simple description',
  datetime: DateTime.now(),
  link: 'https://i.imgur.com/jUOQtxg.jpeg',
);

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

  testWidgets('showSnackBar should display the message on a snackBar',
      (widgetTester) async {
    const _message = 'A simple test message';
    const Key _testKeyTarget = Key('tap-target');

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Utils.showSnackbar(
                  context,
                  _message,
                  Colors.red,
                  const Duration(seconds: 5),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                height: 100.0,
                width: 100.0,
                key: _testKeyTarget,
              ));
        })),
      ),
    );

    await widgetTester.tap(find.byKey(_testKeyTarget));
    await widgetTester.pump();
    expect(find.text(_message), findsOneWidget);
  });

  testWidgets(
      'showAlertDialog should display a dialog alert with a given title and a given message',
      (widgetTester) async {
    const _message = 'A simple test message';
    const _title = 'A simple test title';
    const Key _testKeyTarget = Key('tap-target');

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Utils.showAlertDialog(
                  context,
                  () {},
                  _title,
                  _message,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                height: 100.0,
                width: 100.0,
                key: _testKeyTarget,
              ));
        })),
      ),
    );

    await widgetTester.tap(find.byKey(_testKeyTarget));
    await widgetTester.pump();
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text(_message), findsOneWidget);
    expect(find.text(_title), findsOneWidget);
    expect(find.byType(TextButton), findsWidgets);
  });

  testWidgets('showAlertDialog interactions test', (widgetTester) async {
    const _message = 'A simple test message';
    const _title = 'A simple test title';
    const Key _testKeyTarget = Key('tap-target');

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Utils.showAlertDialog(
                  context,
                  () {},
                  _title,
                  _message,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                height: 100.0,
                width: 100.0,
                key: _testKeyTarget,
              ));
        })),
      ),
    );

    await widgetTester.tap(find.byKey(_testKeyTarget));
    await widgetTester.pump();
    await widgetTester.tap(find.byType(TextButton).first);
    await widgetTester.pump();
    await widgetTester.tap(find.byKey(_testKeyTarget));
    await widgetTester.pump();
    await widgetTester.tap(find.byType(TextButton).last);
  });

  testWidgets('moveToImagePage should navigate us to the ImagePage',
      (widgetTester) async {
    final userBloc = UserBloc();
    userBloc.emit(const UserLoadedState(
        user: UserEntity(
      accessToken: '',
      refreshToken: '',
      accountUsername: '',
      accountId: '',
    )));

    BuildContext? _context;

    mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        MaterialApp(
          onGenerateRoute: AppRouter().onGenerateRoute,
          home: Scaffold(
              body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => userBloc,
              ),
              BlocProvider(
                create: (context) => ProfileGalleryBloc(),
              ),
              BlocProvider(
                create: (context) => FavoriteGalleryBloc(),
              ),
            ],
            child: Builder(builder: (context) {
              _context = context;
              return const HomePage();
            }),
          )),
        ),
      );

      Utils.moveToImagePage(image, _context!);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ImagePage), findsOneWidget);
    });
  });
}
