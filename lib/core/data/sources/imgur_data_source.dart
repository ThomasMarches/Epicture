import 'dart:convert';
import 'dart:developer';

import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/models/imgur_favorite_image.dart';
import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:epicture/core/data/models/imgur_profile_image.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/profile_body.dart';
import 'package:epicture/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ImgurDataSource {
  static Future<UserInformations?> getUserInformations(
    BuildContext context,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        final response = await http.get(
          Uri.parse(
            Constants.getUserInformationsURL + state.user.accountUsername,
          ),
          headers: {'Authorization': 'Client-ID ${Constants.clientId}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET /account/username/  Error code: ${response.statusCode}');
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];
        return jsonData != null ? UserInformations.fromMap(jsonData) : null;
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
        final response = await http.get(Uri.parse(Constants.getUserImagesURL),
            headers: {'Authorization': 'Bearer ${state.user.accessToken}'});

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET /account/me/images  Error code: ${response.statusCode}');
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];

        if (jsonData != null) {
          final finalList = List<ImgurProfileImage>.from(
            jsonData.map(
              (model) => ImgurProfileImage.fromMap(model),
            ),
          );
          return finalList;
        }

        return null;
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
        final response = await http.get(
          Uri.parse(
            Constants.getUserFavoriteImagesURL(
              state.user.accountUsername,
            ),
          ),
          headers: {'Authorization': 'Bearer ${state.user.accessToken}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET /account/username/favorites  Error code: ${response.statusCode}');
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];

        if (jsonData != null) {
          final finalList = List<ImgurFavoriteImage>.from(
            jsonData.map(
              (model) => ImgurFavoriteImage.fromMap(model),
            ),
          );
          return finalList;
        }
        return null;
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<List<ImgurImages>?> searchForImages(
    BuildContext context,
    String? tag,
  ) async {
    final userAssociatedImageList = [];
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      try {
        final response = await http.get(
          Uri.parse(
            Constants.searchImagesURL(
              tag,
            ),
          ),
          headers: {'Authorization': 'Client-ID ${Constants.clientId}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET /gallery/search  Error code: ${response.statusCode}');
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];

        if (jsonData != null) {
          jsonData.forEach((gallery) {
            if (gallery['images'] != null) {
              gallery['images'].forEach((img) {
                userAssociatedImageList.add(img);
              });
            }
          });
        } else {
          return null;
        }

        final finalList = List<ImgurImages>.from(
          userAssociatedImageList.map(
            (model) => ImgurImages.fromMap(model),
          ),
        );
        finalList.removeWhere(
          (element) {
            return (element.type != 'jpg' && element.type != 'png') ||
                element.height > 1000;
          },
        );
        return finalList;
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<List<ImgurImages>?> getHomePageImages(
    BuildContext context,
  ) async {
    final homePageImagesList = [];
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        final response = await http.get(
          Uri.parse(Constants.getHomePageImages),
          headers: {'Authorization': 'Bearer ${state.user.accessToken}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET gallery/search/top/all  Error code: ${response.statusCode}');
        }
        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];

        if (jsonData != null) {
          jsonData.forEach((gallery) {
            if (gallery['images'] != null) {
              gallery['images'].forEach(homePageImagesList.add);
            }
          });
        } else {
          return null;
        }

        final finalList = List<ImgurImages>.from(
          homePageImagesList.map<ImgurImages>(
            (model) => ImgurImages.fromMap(model),
          ),
        );

        finalList.removeWhere(
          (element) {
            return (element.type != 'jpg' && element.type != 'png') ||
                element.height > 600;
          },
        );
        return finalList;
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<bool> favoriteAnImage(
    BuildContext context,
    String hash,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        final response = await http.post(
          Uri.parse(Constants.getFavoriteAnImageURL(hash)),
          headers: {'Authorization': 'Bearer ${state.user.accessToken}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET gallery/search/top/all  Error code: ${response.statusCode}');
        }
        return true;
      } catch (e) {
        log(e.toString());
      }
    }
    return false;
  }

  //TODO: CHECK WHY NOT WORKING ON CERTAIN PICTURES
  static Future<List<ImgurComments>?> getImageComments(
    BuildContext context,
    String id,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        var headers = {'Authorization': 'Client-ID ${Constants.clientId}'};
        var request = http.MultipartRequest(
            'GET', Uri.parse('https://api.imgur.com/3/gallery/$id/comments/'));
        request.fields.addAll({
          'access_token': state.user.accessToken,
        });

        request.headers.addAll(headers);

        http.StreamedResponse streamedResponse = await request.send();

        if (streamedResponse.statusCode == 200) {
          final response = await Response.fromStream(streamedResponse);
          final jsonResponse = jsonDecode(response.body);
          final jsonData = jsonResponse?['data'];
          if (jsonData == null) return null;

          final finalList = List<ImgurComments>.from(
            jsonData.map<ImgurComments>(
              (model) => ImgurComments.fromMap(model),
            ),
          );
          return finalList;
        } else {
          return null;
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<ImgurComments?> createCommentOnImage(
    BuildContext context,
    String id,
    String comment,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        final response = await http.post(
          Uri.parse(Constants.createCommentURL),
          headers: {'Authorization': 'Bearer ${state.user.accessToken}'},
          body: {
            'image_id': id,
            'comment': comment,
          },
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call POST image/comments  Error code: ${response.statusCode}');
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];

        print(jsonData);
        if (jsonData == null) return null;

        if (jsonData is Map<String, dynamic>) {
          return await convertIdToComment(
              context, jsonData.values.first.toString());
        } else {
          return null;
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<ImgurComments?> convertIdToComment(
    BuildContext context,
    String commentId,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        final response = await http.get(
          Uri.parse(Constants.commentChangeURL(commentId)),
          headers: {'Authorization': 'Bearer ${state.user.accessToken}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET comment informations  Error code: ${response.statusCode}');
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];

        if (jsonData == null) return null;

        return ImgurComments.fromMap(jsonData);
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<bool> voteOnComment(
    BuildContext context,
    String commentId,
    String vote,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        final response = await http.post(
          Uri.parse(Constants.voteOnCommentURL(commentId, vote)),
          headers: {'Authorization': 'Bearer ${state.user.accessToken}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call POST image/comments  Error code: ${response.statusCode}');
        }

        return true;
      } catch (e) {
        log(e.toString());
      }
    }
    return false;
  }

  static Future<bool> deleteComment(
    BuildContext context,
    String commentId,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        final response = await http.delete(
          Uri.parse(Constants.commentChangeURL(commentId)),
          headers: {'Authorization': 'Bearer ${state.user.accessToken}'},
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Error from API call GET comment informations  Error code: ${response.statusCode}');
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse?['data'];

        if (jsonData == null) return false;

        return true;
      } catch (e) {
        log(e.toString());
      }
    }
    return false;
  }
}
