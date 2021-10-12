part of 'favorite_gallery_bloc.dart';

abstract class FavoriteGalleryBlocEvent {
  const FavoriteGalleryBlocEvent();
}

class FetchFavoriteGalleryPictureEvent extends FavoriteGalleryBlocEvent {
  const FetchFavoriteGalleryPictureEvent(
      {required this.accountUsername, required this.accessToken});

  final String accountUsername;
  final String accessToken;
}
