import 'dart:convert';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/preview_page.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

final image = ImgurPost(
  id: 'CiTPwEY',
  author: null,
  content: [],
  isAlbum: false,
  type: 'jpeg',
  vote: 'up',
  favorite: true,
  title: 'TestTitle',
  description: 'A simple description',
  datetime: DateTime.now(),
  link: 'https://i.imgur.com/jUOQtxg.jpeg',
  views: 10,
  downs: 0,
  ups: 0,
);

void main() {
  group('ImagePage', () {
    testWidgets('renders an image without comment', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(
            home: PreviewPage(arguments: PreviewPageArguments(post: image))));
      }).then((value) {
        expect(find.byType(PreviewPage), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byIcon(Icons.keyboard_arrow_left), findsOneWidget);
        expect(find.text('Epicture'), findsOneWidget);
        expect(find.text(image.title!), findsOneWidget);
        expect(
            find.text('Uploaded: ${Utils.getTimeDifference(DateTime.now())}'),
            findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
        expect(find.text('No comment yet.'), findsOneWidget);
        expect(find.byType(SizedBox), findsWidgets);
        expect(find.byIcon(Icons.arrow_downward_sharp), findsOneWidget);
        expect(find.byIcon(Icons.arrow_upward_sharp), findsOneWidget);
      });
    });

    testWidgets('renders an image with comments', (tester) async {
      const String username = 'TestAuthor';

      final file =
          File('test/ressources/imgur_comments_list.json').readAsStringSync();

      final jsonResponse = jsonDecode(file);
      final jsonData = jsonResponse['data'];

      final commentsList = List<ImgurComments>.from(
        jsonData.map<ImgurComments>(
          (model) => ImgurComments.fromMap(model),
        ),
      );

      mockNetworkImagesFor(() async {
        final userBloc = UserBloc();
        userBloc.emit(const UserLoadedState(
            user: UserEntity(
          accessToken: '',
          refreshToken: '',
          accountUsername: username,
          accountId: '',
        )));
        await tester.pumpWidget(BlocProvider(
          create: (context) => userBloc,
          child: MaterialApp(
            home: PreviewPage(
              arguments: PreviewPageArguments(post: image),
              commentsList: commentsList,
            ),
          ),
        ));
      }).then((value) {
        expect(find.byIcon(Icons.arrow_downward_sharp), findsWidgets);
        expect(find.byIcon(Icons.arrow_upward_sharp), findsWidgets);
        for (int i = 0; i != commentsList.length; i++) {
          expect(find.text(commentsList[i].comment), findsOneWidget);
          expect(find.text(commentsList[i].ups.toString()), findsWidgets);
          if (commentsList[i].author == username) {
            expect(find.text('Written by: You'), findsWidgets);
            expect(find.byIcon(Icons.delete), findsWidgets);
          } else {
            expect(find.text('Written by: ${commentsList[i].author}'),
                findsWidgets);
          }
          expect(
              find.text(
                  'Uploaded: ${Utils.getTimeDifference(commentsList[i].datetime)}'),
              findsWidgets);
        }
      });
    });
  });
}
