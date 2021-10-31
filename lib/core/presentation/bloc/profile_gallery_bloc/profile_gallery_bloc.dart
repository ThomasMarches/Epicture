import 'package:bloc/bloc.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';

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

    final userPostList = await ImgurDataSource.getUserPosts(accessToken);

    if (userPostList == null) {
      yield FetchProfileGalleryPictureFailure();
      return;
    }

    yield FetchProfileGalleryPictureSuccess(userPostList: userPostList);
  }
}
