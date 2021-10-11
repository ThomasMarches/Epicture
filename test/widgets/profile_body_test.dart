import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/profile_gallery_bloc/profile_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/profile_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('ProfileBody test', () {
    testWidgets('Renders profile body without UserInformations',
        (widgetTester) async {
      final userBloc = UserBloc();
      userBloc.emit(const UserLoadedState(
          user: UserEntity(
        accessToken: '',
        refreshToken: '',
        accountUsername: '',
        accountId: '',
      )));

      return await widgetTester
          .pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => userBloc,
          ),
          BlocProvider(
            create: (context) => ProfileGalleryBloc(),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(body: ProfileBody()),
        ),
      ))
          .then((value) {
        expect(find.byType(SizedBox), findsWidgets);
        expect(find.text('Username'), findsOneWidget);
        expect(find.text('Neutral'), findsOneWidget);
        expect(find.text('No descritpion.'), findsOneWidget);
        expect(find.text('0'), findsOneWidget);
        expect(
            find.text('Couldn\'t load your profile pictures'), findsOneWidget);
      });
    });

    testWidgets(
        'Renders profile body with ProgressIndicator if API call is processing',
        (widgetTester) async {
      final userBloc = UserBloc();
      userBloc.emit(const UserLoadedState(
          user: UserEntity(
        accessToken: '',
        refreshToken: '',
        accountUsername: '',
        accountId: '',
      )));

      final profileBloc = ProfileGalleryBloc();
      profileBloc.emit(FetchProfileGalleryPictureLoading());

      return await widgetTester
          .pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => userBloc,
          ),
          BlocProvider(
            create: (context) => profileBloc,
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(body: ProfileBody()),
        ),
      ))
          .then((value) {
        expect(find.byType(CircularProgressIndicator), findsWidgets);
      });
    });
  });
}
