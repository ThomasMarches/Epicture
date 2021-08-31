import 'dart:convert';
import 'dart:developer';

import 'package:epicture/core/data/models/imgur_favorite_image.dart';
import 'package:epicture/core/data/models/imgur_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/profile_body.dart';
import 'package:epicture/core/utils/constants.dart';

class ImgurDataSource {
  static Future<UserInformations?> getUserInformations(
    BuildContext context,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        var response = await http.get(
            Uri.parse(
                Constants.getUserInformationsURL + state.user.accountUsername),
            headers: {'Authorization': 'Client-ID ${Constants.clientId}'});

        if (response.statusCode != 200) {
          throw (Exception(
              'Error from API call GET /account/username/  Error code: ${response.statusCode}'));
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse['data'];

        return UserInformations.fromMap(jsonData);
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<List<ImgurProfileImage>?> getUserImages(
    BuildContext context,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        var response = await http.get(Uri.parse(Constants.getUserImagesURL),
            headers: {'Authorization': 'Bearer ${state.user.accessToken}'});

        if (response.statusCode != 200) {
          throw (Exception(
              'Error from API call GET /account/me/images  Error code: ${response.statusCode}'));
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse['data'];

        return List<ImgurProfileImage>.from(
            jsonData.map((model) => ImgurProfileImage.fromMap(model)));
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<List<ImgurFavoriteImage>?> getUserFavoriteImages(
    BuildContext context,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        var response = await http.get(
            Uri.parse(
                Constants.getUserFavoriteImages(state.user.accountUsername)),
            headers: {'Authorization': 'Bearer ${state.user.accessToken}'});

        if (response.statusCode != 200) {
          throw (Exception(
              'Error from API call GET /account/username/favorites  Error code: ${response.statusCode}'));
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse['data'];

        return List<ImgurFavoriteImage>.from(
            jsonData.map((model) => ImgurFavoriteImage.fromMap(model)));
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }
}
