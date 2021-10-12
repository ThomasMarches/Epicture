import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/favorite_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteBody', () {
    testWidgets('renders FavoriteBody with ProgressIndicator if no pictures',
        (tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(),
          ),
          BlocProvider(
            create: (context) => FavoriteGalleryBloc(),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: FavoriteBody(),
          ),
        ),
      ));
      expect(find.byType(FavoriteBody), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
