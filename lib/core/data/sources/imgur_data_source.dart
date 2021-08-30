import 'dart:convert';
import 'dart:developer';

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
  final String? favorite;
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

  static Future<List<ImgurImages>?> getUserImages(
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

        return List<ImgurImages>.from(
            jsonData.map((model) => ImgurImages.fromMap(model)));
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }
}
