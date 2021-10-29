import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('HomeBody', () {
    testWidgets(
        'renders HomeBody with CircularProgressIndicator if no pictures',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: HomeBody(),
        ),
      ));
      expect(find.byType(HomeBody), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders HomeBody with pictures', (tester) async {
      final file =
          File('test/ressources/imgur_post_list.json').readAsStringSync();

      final jsonResponse = jsonDecode(file);
      final jsonData = jsonResponse['data'];

      final imageList = List<ImgurPost>.from(
        jsonData.map<ImgurPost>(
          (model) => ImgurPost.fromMap(model),
        ),
      );

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
          child: MaterialApp(
            home: HomeBody(
              homePagePostList: imageList,
            ),
          ),
        ));
      });
    });
  });
}
