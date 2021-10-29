part of 'favorite_gallery_bloc.dart';

abstract class FavoriteGalleryBlocState {
  const FavoriteGalleryBlocState();
}

class FavoriteGalleryBlocInitialState extends FavoriteGalleryBlocState {}

class FetchFavoriteGalleryPictureLoading extends FavoriteGalleryBlocState {}

class FetchFavoriteGalleryPictureFailure extends FavoriteGalleryBlocState {}

class FetchFavoriteGalleryPictureSuccess extends FavoriteGalleryBlocState {
  const FetchFavoriteGalleryPictureSuccess({
    this.userFavoritePostList,
  });

  final List<ImgurPost>? userFavoritePostList;
}
