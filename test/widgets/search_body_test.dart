import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('SearchBody', () {
    testWidgets('renders SearchBody', (tester) async {
      mockNetworkImagesFor(() async {
        final userBloc = UserBloc();
        userBloc.emit(const UserLoadedState(
            user: UserEntity(
          accessToken: '',
          refreshToken: '',
          accountUsername: '',
          accountId: '',
        )));
        await tester.pumpWidget(BlocProvider(
          create: (context) => userBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: SearchBody(),
            ),
          ),
        ));
      }).then((value) async {
        expect(find.byType(SearchBody), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
        await tester.enterText(find.byType(TextField), 'testTag');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
        expect(find.text('testTag'), findsOneWidget);
      });
    });
  });
}
