import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/profile_gallery_bloc/profile_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/login_page.dart';
import 'package:epicture/core/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRouter', (() {
    testWidgets('AppRouter basic route should be LoginPage',
        (widgetTester) async {
      final userBloc = UserBloc();
      userBloc.emit(const UserLoadedState(
          user: UserEntity(
        accessToken: '',
        refreshToken: '',
        accountUsername: '',
        accountId: '',
      )));

      await widgetTester.pumpWidget(MultiBlocProvider(
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
        child: MaterialApp(
          onGenerateRoute: AppRouter().onGenerateRoute,
        ),
      ));
      expect(find.byType(LoginPage), findsOneWidget);
    });
  }));
}
