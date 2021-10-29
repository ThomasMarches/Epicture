import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/data/models/user_informations.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ImgurDataSource {
  static Future<UserInformations?> getUserInformations(
    String accountUsername,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          Constants.getUserInformationsURL + accountUsername,
        ),
        headers: {'Authorization': 'Client-ID ${Constants.clientId}'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getUserInformationsURL + accountUsername}.  Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];
      return jsonData != null ? UserInformations.fromMap(jsonData) : null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<ImgurPost>?> getUserPosts(
    String accessToken,
  ) async {
    try {
      final response = await http.get(Uri.parse(Constants.getUserPostURL),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getUserPostURL}.  Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData != null) {
        final finalList = List<ImgurPost>.from(
          jsonData.map(
            (model) => ImgurPost.fromMap(model),
          ),
        );
        return finalList;
      }

      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<ImgurPost>?> getUserFavoritePosts(
    String accountUsername,
    String accessToken,
  ) async {
    final List<ImgurPost> favoritePostList = [];
    try {
      final response = await http.get(
        Uri.parse(Constants.userFavoritePostsURL(accountUsername)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.userFavoritePostsURL(accountUsername)}. Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData != null) {
        final linkList = List<String>.from(
          jsonData.map(
            (model) => model['id'] as String,
          ),
        );

        for (var element in linkList) {
          final response = await http.get(
            Uri.parse(Constants.getGalleryInformationURL(element)),
            headers: {'Authorization': 'Bearer $accessToken'},
          );

          if (response.statusCode != 200) {
            throw Exception(
                'Error from API call GET ${Constants.getGalleryInformationURL(element)}. Error code: ${response.statusCode}');
          }

          final jsonResponse = jsonDecode(response.body);
          final jsonData = jsonResponse?['data'];

          favoritePostList.add(ImgurPost.fromMap(jsonData));
        }
        return _cleanImgurPostList(favoritePostList);
      }
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<ImgurPost>?> searchForPosts(
    String? tag,
    String sort,
    String window,
  ) async {
    final List<ImgurPost> userAssociatedPostsList = [];
    try {
      final response = await http.get(
        Uri.parse(Constants.searchPostURL(tag, sort, window)),
        headers: {'Authorization': 'Client-ID ${Constants.clientId}'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.searchPostURL(tag, sort, window)}.  Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData != null) {
        jsonData.forEach((model) {
          userAssociatedPostsList.add(ImgurPost.fromMap(model));
        });
      } else {
        return null;
      }

      return _cleanImgurPostList(userAssociatedPostsList);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<ImgurPost>?> getHomePagePosts(
    BuildContext context,
  ) async {
    final List<ImgurPost> homePagePostList = [];
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.get(
        Uri.parse(Constants.getHomePagePosts),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getHomePagePosts}.  Error code: ${response.statusCode}');
      }
      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData != null) {
        jsonData.forEach((model) {
          homePagePostList.add(ImgurPost.fromMap(model));
        });
      } else {
        return null;
      }

      return _cleanImgurPostList(homePagePostList);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<bool> favoriteAPost(
    BuildContext context,
    String hash,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.post(
        Uri.parse(Constants.getFavoriteAPostURL(hash)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getFavoriteAPostURL(hash)}.  Error code: ${response.statusCode}');
      }
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<List<ImgurComments>?> getPostComments(
    BuildContext context,
    String id,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      var headers = {'Authorization': 'Client-ID ${Constants.clientId}'};
      var request = http.MultipartRequest(
          'GET', Uri.parse(Constants.getPostCommentsURL(id)));
      request.fields.addAll({
        'access_token': accessToken,
      });

      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        final response = await http.Response.fromStream(streamedResponse);
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
        throw Exception(
            'Error from API call POST ${Constants.getPostCommentsURL(id)}.  Error code: ${streamedResponse.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<ImgurComments?> createCommentOnImage(
    BuildContext context,
    String id,
    String comment,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.post(
        Uri.parse(Constants.createCommentURL),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'image_id': id,
          'comment': comment,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call POST ${Constants.createCommentURL}.  Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

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
    return null;
  }

  static Future<ImgurComments?> convertIdToComment(
    BuildContext context,
    String commentId,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.get(
        Uri.parse(Constants.commentChangeURL(commentId)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.commentChangeURL(commentId)}. Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData == null) return null;

      return ImgurComments.fromMap(jsonData);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<bool> voteOnComment(
    BuildContext context,
    String commentId,
    String vote,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.post(
        Uri.parse(Constants.voteOnCommentURL(commentId, vote)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call POST ${Constants.voteOnCommentURL(commentId, vote)}. Error code: ${response.statusCode}');
      }

      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<bool> deleteComment(
    BuildContext context,
    String commentId,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.delete(
        Uri.parse(Constants.commentChangeURL(commentId)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call DELETE ${Constants.commentChangeURL(commentId)}. Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData == null) return false;

      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<bool> deletePost(
    BuildContext context,
    String postId,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.delete(
        Uri.parse(Constants.deletePostURL(postId)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call DELETE ${Constants.deletePostURL(postId)}. Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData == null) return false;

      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<bool> uploadPost(
    BuildContext context,
    String? postTitle,
    String? postDescription,
    File image,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.post(
        Uri.parse(Constants.uploadPostURL),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'image': base64Encode(await image.readAsBytes()),
          'type': 'base64',
          'title': (postTitle == null) ? 'Image title' : postTitle,
          'description':
              (postDescription == null) ? 'Image description' : postDescription,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call POST ${Constants.uploadPostURL}. Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData == null) return false;

      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<bool> updateUserInformations(
    BuildContext context,
    UserInformations? userInformations,
  ) async {
    try {
      if (userInformations == null) return false;

      final accountUsername = _getUserUsernameFromBloc(context);
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.put(
        Uri.parse(Constants.changeAccountSettingsURL(accountUsername)),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'username': userInformations.userName,
          'bio': userInformations.bio
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call POST ${Constants.changeAccountSettingsURL(accountUsername)}. Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData == null) return false;
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static String _getUserAccessTokenFromBloc(BuildContext context) {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    return (userBlocState.user.accessToken);
  }

  static String _getUserUsernameFromBloc(BuildContext context) {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    return (userBlocState.user.accountUsername);
  }

  static List<ImgurPost> _cleanImgurPostList(List<ImgurPost> postList) {
    postList.removeWhere(
      (element) {
        if (!element.isAlbum) {
          return element.type != 'jpeg' &&
              element.type != 'png' &&
              element.type != 'jpg';
        } else {
          for (var model in element.content) {
            if (!model.contains('jpeg') &&
                !model.contains('jpg') &&
                !model.contains('png')) {
              return (true);
            }
          }
          return false;
        }
      },
    );
    return postList;
  }
}
