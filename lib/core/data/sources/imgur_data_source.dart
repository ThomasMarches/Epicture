import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/models/imgur_image.dart';
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

  static Future<List<ImgurImages>?> getUserImages(
    String accessToken,
  ) async {
    try {
      final response = await http.get(Uri.parse(Constants.getUserImagesURL),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getUserImagesURL}.  Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData != null) {
        final finalList = List<ImgurImages>.from(
          jsonData.map(
            (model) => ImgurImages.fromMap(model),
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

  static Future<List<ImgurImages>?> getUserFavoriteImages(
    String accountUsername,
    String accessToken,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(Constants.getUserFavoriteImagesURL(accountUsername)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getUserFavoriteImagesURL(accountUsername)}. Error code: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final jsonData = jsonResponse?['data'];

      if (jsonData != null) {
        final finalList = List<ImgurImages>.from(
          jsonData.map(
            (model) => ImgurImages.fromMap(model),
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

  static Future<List<ImgurImages>?> searchForImages(
    String? tag,
  ) async {
    final userAssociatedImageList = [];
    try {
      final response = await http.get(
        Uri.parse(Constants.searchImagesURL(tag)),
        headers: {'Authorization': 'Client-ID ${Constants.clientId}'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.searchImagesURL(tag)}.  Error code: ${response.statusCode}');
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
          return (element.type != 'jpeg' && element.type != 'png') ||
              element.height > 600;
        },
      );
      return finalList;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<ImgurImages>?> getHomePageImages(
    BuildContext context,
  ) async {
    final homePageImagesList = [];
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.get(
        Uri.parse(Constants.getHomePageImages),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getHomePageImages}.  Error code: ${response.statusCode}');
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
          return (element.type != 'jpeg' && element.type != 'png') ||
              element.height > 600;
        },
      );
      return finalList;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<bool> favoriteAnImage(
    BuildContext context,
    String hash,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.post(
        Uri.parse(Constants.getFavoriteAnImageURL(hash)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call GET ${Constants.getFavoriteAnImageURL(hash)}.  Error code: ${response.statusCode}');
      }
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<List<ImgurComments>?> getImageComments(
    BuildContext context,
    String id,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      var headers = {'Authorization': 'Client-ID ${Constants.clientId}'};
      var request = http.MultipartRequest(
          'GET', Uri.parse(Constants.getImageCommentsURL(id)));
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
            'Error from API call POST ${Constants.getImageCommentsURL(id)}.  Error code: ${streamedResponse.statusCode}');
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

  static Future<bool> deleteImage(
    BuildContext context,
    String imageId,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.delete(
        Uri.parse(Constants.deleteImageURL(imageId)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call DELETE ${Constants.deleteImageURL(imageId)}. Error code: ${response.statusCode}');
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

  static Future<bool> uploadImage(
    BuildContext context,
    String? imageTitle,
    String? imageDescription,
    File image,
  ) async {
    try {
      final accessToken = _getUserAccessTokenFromBloc(context);
      final response = await http.post(
        Uri.parse(Constants.uploadImageURL),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'image': base64Encode(await image.readAsBytes()),
          'type': 'base64',
          'title': (imageTitle == null) ? 'Image title' : imageTitle,
          'description': (imageDescription == null)
              ? 'Image description'
              : imageDescription,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error from API call POST ${Constants.uploadImageURL}. Error code: ${response.statusCode}');
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

      final accessToken = _getUserAccessTokenFromBloc(context);
      final accountUsername = _getUserUsernameFromBloc(context);
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
}
