import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/profile_gallery_bloc/profile_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomePage tests', () {
    testWidgets('renders HomePage test', (widgetTester) async {
      final userBloc = UserBloc();
      userBloc.emit(const UserLoadedState(
          user: UserEntity(
        accessToken: '',
        refreshToken: '',
        accountUsername: '',
        accountId: '',
      )));

      await widgetTester.pumpWidget(MaterialApp(
          home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => userBloc,
          ),
          BlocProvider(
            create: (context) => FavoriteGalleryBloc(),
          ),
          BlocProvider(
            create: (context) => ProfileGalleryBloc(),
          ),
        ],
        child: const HomePage(),
      )));
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
