part of 'profile_gallery_bloc.dart';

abstract class ProfileGalleryBlocState {
  const ProfileGalleryBlocState();
}

class ProfileGalleryBlocInitialState extends ProfileGalleryBlocState {}

class FetchProfileGalleryPictureLoading extends ProfileGalleryBlocState {}

class FetchProfileGalleryPictureFailure extends ProfileGalleryBlocState {}

class FetchProfileGalleryPictureSuccess extends ProfileGalleryBlocState {
  const FetchProfileGalleryPictureSuccess({
    this.userPostList,
  });

  final List<ImgurPost>? userPostList;
}
