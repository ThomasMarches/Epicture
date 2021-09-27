import 'package:bloc/bloc.dart';
import 'package:epicture/core/data/models/imgur_profile_image.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:equatable/equatable.dart';

part 'profile_gallery_event.dart';
part 'profile_gallery_state.dart';

class ProfileGalleryBloc
    extends Bloc<ProfileGalleryBlocEvent, ProfileGalleryBlocState> {
  ProfileGalleryBloc() : super(ProfileGalleryBlocInitialState());

  @override
  Stream<ProfileGalleryBlocState> mapEventToState(
    ProfileGalleryBlocEvent event,
  ) async* {
    if (event is FetchProfileGalleryPictureEvent) {
      yield* _fetchProfileGalleryPictureEventToState(event.accessToken);
    }
  }

  Stream<ProfileGalleryBlocState> _fetchProfileGalleryPictureEventToState(
    String accessToken,
  ) async* {
    yield FetchProfileGalleryPictureLoading();

    final userImagesList = await ImgurDataSource.getUserImages(accessToken);

    if (userImagesList == null) {
      yield FetchProfileGalleryPictureFailure();
      return;
    }

    yield FetchProfileGalleryPictureSuccess(userImagesList: userImagesList);
  }
}