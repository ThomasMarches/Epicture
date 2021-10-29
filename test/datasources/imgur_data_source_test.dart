import 'package:epicture/core/data/models/user_informations.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('ImgurDataSource', (() {
    testWidgets('updateUserInformations should return false on Exception',
        (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.updateUserInformations(
          _context!,
          UserInformations(
            userName: '',
            reputation: 0,
            bio: '',
            reputationName: '',
            avatar: '',
            id: 0,
          ),
        ),
        false,
      );
    });

    testWidgets('deleteImage should return false on Exception', (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.deletePost(
          _context!,
          'imageId',
        ),
        false,
      );
    });

    testWidgets('searchForImages should return null on Exception',
        (tester) async {
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
        child: const MaterialApp(home: Scaffold()),
      ));

      expect(
        await ImgurDataSource.searchForPosts(
          'testTag',
          'time',
          'all',
        ),
        null,
      );
    });

    testWidgets('favoriteAnImage should return false on Exception',
        (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.favoriteAPost(
          _context!,
          'testTag',
        ),
        false,
      );
    });

    testWidgets('getImageComments should return null on Exception',
        (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.getPostComments(
          _context!,
          'testId',
        ),
        null,
      );
    });

    testWidgets('createCommentOnImage should return null on Exception',
        (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.createCommentOnImage(
          _context!,
          'testId',
          'testComment',
        ),
        null,
      );
    });

    testWidgets('convertIdToComment should return null on Exception',
        (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.convertIdToComment(
          _context!,
          'testId',
        ),
        null,
      );
    });

    testWidgets('voteOnComment should return false on Exception',
        (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.voteOnComment(
          _context!,
          'testId',
          'testVote',
        ),
        false,
      );
    });

    testWidgets('deleteComment should return false on Exception',
        (tester) async {
      BuildContext? _context;
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
            home: Scaffold(body: Builder(builder: (BuildContext context) {
          _context = context;
          return Container();
        }))),
      ));

      expect(
        await ImgurDataSource.deleteComment(
          _context!,
          'testId',
        ),
        false,
      );
    });
  }));
}
