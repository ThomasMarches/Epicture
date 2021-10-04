part of 'favorite_gallery_bloc.dart';

abstract class FavoriteGalleryBlocEvent extends Equatable {
  const FavoriteGalleryBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteGalleryPictureEvent extends FavoriteGalleryBlocEvent {
  const FetchFavoriteGalleryPictureEvent(
      {required this.accountUsername, required this.accessToken});

  final String accountUsername;
  final String accessToken;

  @override
  List<Object> get props => [accountUsername, accessToken];
}
