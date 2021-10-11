part of 'profile_gallery_bloc.dart';

abstract class ProfileGalleryBlocState extends Equatable {
  const ProfileGalleryBlocState();

  @override
  List<Object> get props => [];
}

class ProfileGalleryBlocInitialState extends ProfileGalleryBlocState {}

class FetchProfileGalleryPictureLoading extends ProfileGalleryBlocState {}

class FetchProfileGalleryPictureFailure extends ProfileGalleryBlocState {}

class FetchProfileGalleryPictureSuccess extends ProfileGalleryBlocState {
  const FetchProfileGalleryPictureSuccess({
    this.userImagesList,
  });

  final List<ImgurImages>? userImagesList;
}
