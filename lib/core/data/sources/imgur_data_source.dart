import 'dart:convert';
import 'dart:developer';

import 'package:epicture/core/data/models/imgur_favorite_image.dart';
import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:epicture/core/data/models/imgur_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/pages/profile_body.dart';
import 'package:epicture/core/utils/constants.dart';

class ImgurImages {
  const ImgurImages({
    required this.id,
    required this.title,
    required this.description,
    required this.datetime,
    required this.type,
    required this.animated,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.vote,
    required this.favorite,
    required this.section,
    required this.accountUrl,
    required this.accountId,
    required this.isAd,
    required this.inMostViral,
    required this.hasSound,
    required this.tags,
    required this.adType,
    required this.adUrl,
    required this.edited,
    required this.inGallery,
    required this.deletehash,
    required this.name,
    required this.link,
  });

  factory ImgurImages.fromMap(Map<String, dynamic> map) {
    return ImgurImages(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
      type: map['type'],
      animated: map['animated'],
      width: map['width'],
      height: map['height'],
      size: map['size'],
      views: map['views'],
      vote: map['vote'],
      favorite: map['favorite'],
      section: map['section'],
      accountUrl: map['account_url'],
      accountId: map['account_id'],
      isAd: map['is_ad'],
      inMostViral: map['in_most_viral'],
      hasSound: map['has_sound'],
      tags: List.from(map['tags']),
      adType: map['ad_type'],
      adUrl: map['ad_url'],
      edited: map['edited'],
      inGallery: map['in_gallery'],
      deletehash: map['deletehash'],
      name: map['name'],
      link: map['link'],
    );
  }

  final String id;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String type;
  final bool animated;
  final int width;
  final int height;
  final int size;
  final int views;
  final String? vote;
  final bool favorite;
  final String? section;
  final String accountUrl;
  final int accountId;
  final bool isAd;
  final bool inMostViral;
  final bool hasSound;
  final List tags;
  final int adType;
  final String adUrl;
  final String edited;
  final bool inGallery;
  final String deletehash;
  final String name;
  final String link;
}

class HomePageImages {
  const HomePageImages({
    required this.id,
    required this.title,
    required this.description,
    required this.datetime,
    required this.type,
    required this.animated,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.bandwidth,
    required this.vote,
    required this.favorite,
    required this.nsfw,
    required this.section,
    required this.accountUrl,
    required this.accountId,
    required this.isAd,
    required this.inMostViral,
    required this.hasSound,
    required this.tags,
    required this.adType,
    required this.adUrl,
    required this.edited,
    required this.inGallery,
    required this.topic,
    required this.topicId,
    required this.deletehash,
    required this.name,
    required this.link,
    required this.looping,
    required this.commentCount,
    required this.favoriteCount,
    required this.ups,
    required this.downs,
    required this.points,
    required this.score,
  });

  factory HomePageImages.fromMap(Map<String, dynamic> map) {
    return HomePageImages(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
      type: map['type'],
      animated: map['animated'],
      width: map['width'],
      height: map['height'],
      size: map['size'],
      views: map['views'],
      bandwidth: map['bandwidth'],
      vote: map['vote'],
      favorite: map['favorite'],
      nsfw: map['nsfw'],
      section: map['section'],
      accountUrl: map['account_url'],
      accountId: map['account_id'],
      isAd: map['is_ad'],
      inMostViral: map['in_most_viral'],
      hasSound: map['has_sound'],
      tags: List.from(map['tags']),
      adType: map['ad_type'],
      adUrl: map['ad_url'],
      edited: map['edited'],
      inGallery: map['in_gallery'],
      topic: map['topic'],
      topicId: map['topic_id'],
      deletehash: map['deletehash'],
      name: map['name'],
      link: map['link'],
      looping: map['looping'],
      commentCount: map['comment_count'],
      favoriteCount: map['favorite_count'],
      ups: map['ups'],
      downs: map['downs'],
      points: map['points'],
      score: map['score'],
    );
  }

  final String id;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String type;
  final bool animated;
  final int width;
  final int height;
  final int size;
  final int views;
  final int bandwidth;
  final String? vote;
  final bool favorite;
  final bool nsfw;
  final String? section;
  final String accountUrl;
  final int accountId;
  final bool isAd;
  final bool inMostViral;
  final bool hasSound;
  final List tags;
  final int adType;
  final String adUrl;
  final int edited;
  final bool inGallery;
  final bool? topic;
  final int topicId;
  final String deletehash;
  final String name;
  final String link;
  final bool looping;
  final int commentCount;
  final int favoriteCount;
  final int ups;
  final int downs;
  final int points;
  final int score;
}

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
            Constants.getUserInformationsURL + state.user.accountUsername,
          ),
          headers: {'Authorization': 'Client-ID ${Constants.clientId}'},
        );

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
          jsonData.map(
            (model) => ImgurProfileImage.fromMap(model),
          ),
        );
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
              Constants.getUserFavoriteImagesURL(
                state.user.accountUsername,
              ),
            ),
            headers: {'Authorization': 'Bearer ${state.user.accessToken}'});

        if (response.statusCode != 200) {
          throw (Exception(
              'Error from API call GET /account/username/favorites  Error code: ${response.statusCode}'));
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse['data'];

        return List<ImgurFavoriteImage>.from(
          jsonData.map(
            (model) => ImgurFavoriteImage.fromMap(model),
          ),
        );
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<List<ImgurImages>?> getUserAssociatedImages(
    BuildContext context,
    String? tag,
  ) async {
    var userAssociatedImageList = [];
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      try {
        var response = await http.get(
            Uri.parse(
              Constants.searchImagesURL(
                tag,
              ),
            ),
            headers: {'Authorization': 'Client-ID ${Constants.clientId}'});

        if (response.statusCode != 200) {
          throw (Exception(
              'Error from API call GET /gallery/search  Error code: ${response.statusCode}'));
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse['data'];

        if (jsonData != null) {
          jsonData.forEach((dynamic gallery) {
            if (gallery['images'] != null) {
              gallery['images'].forEach((dynamic img) {
                userAssociatedImageList.add(img);
              });
            }
          });
        }

        print(userAssociatedImageList);
        return List<ImgurImages>.from(
          userAssociatedImageList.map(
            (model) => ImgurImages.fromMap(model),
          ),
        );
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }

  static Future<List<HomePageImages>?> getHomePageImages(
    BuildContext context,
  ) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        var response = await http.get(Uri.parse(Constants.getHomePageImages),
            headers: {'Authorization': 'Bearer ${state.user.accessToken}'});

        if (response.statusCode != 200) {
          throw (Exception(
              'Error from API call GET gallery/search/top/all  Error code: ${response.statusCode}'));
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse['data'];
        print(jsonData);

        return List<HomePageImages>.from(
            jsonData.map((model) => HomePageImages.fromMap(model)));
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }
}
