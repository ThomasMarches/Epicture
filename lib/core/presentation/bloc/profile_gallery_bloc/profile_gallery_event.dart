part of 'profile_gallery_bloc.dart';

abstract class ProfileGalleryBlocEvent extends Equatable {
  const ProfileGalleryBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileGalleryPictureEvent extends ProfileGalleryBlocEvent {
  const FetchProfileGalleryPictureEvent({required this.accessToken});

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}
