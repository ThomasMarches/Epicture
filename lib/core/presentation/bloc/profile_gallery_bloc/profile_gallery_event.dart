part of 'profile_gallery_bloc.dart';

abstract class ProfileGalleryBlocEvent {
  const ProfileGalleryBlocEvent();
}

class FetchProfileGalleryPictureEvent extends ProfileGalleryBlocEvent {
  const FetchProfileGalleryPictureEvent({required this.accessToken});

  final String accessToken;
}
