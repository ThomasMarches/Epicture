part of 'favorite_gallery_bloc.dart';

abstract class FavoriteGalleryBlocState extends Equatable {
  const FavoriteGalleryBlocState();

  @override
  List<Object> get props => [];
}

class FavoriteGalleryBlocInitialState extends FavoriteGalleryBlocState {}

class FetchFavoriteGalleryPictureLoading extends FavoriteGalleryBlocState {}

class FetchFavoriteGalleryPictureFailure extends FavoriteGalleryBlocState {}

class FetchFavoriteGalleryPictureSuccess extends FavoriteGalleryBlocState {
  const FetchFavoriteGalleryPictureSuccess({
    this.userFavoriteImageList,
  });

  final List<ImgurFavoriteImage>? userFavoriteImageList;
}
