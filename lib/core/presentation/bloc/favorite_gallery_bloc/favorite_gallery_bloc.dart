import 'package:bloc/bloc.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';

part 'favorite_gallery_event.dart';
part 'favorite_gallery_state.dart';

class FavoriteGalleryBloc
    extends Bloc<FavoriteGalleryBlocEvent, FavoriteGalleryBlocState> {
  FavoriteGalleryBloc() : super(FavoriteGalleryBlocInitialState());

  @override
  Stream<FavoriteGalleryBlocState> mapEventToState(
    FavoriteGalleryBlocEvent event,
  ) async* {
    if (event is FetchFavoriteGalleryPictureEvent) {
      yield* _fetchFavoriteGalleryPictureEventToState(
          event.accountUsername, event.accessToken);
    }
  }

  Stream<FavoriteGalleryBlocState> _fetchFavoriteGalleryPictureEventToState(
    String accountUsername,
    String accessToken,
  ) async* {
    yield FetchFavoriteGalleryPictureLoading();

    final userFavoritePostList = await ImgurDataSource.getUserFavoritePosts(
        accountUsername, accessToken);

    if (userFavoritePostList == null) {
      yield FetchFavoriteGalleryPictureFailure();
      return;
    }

    yield FetchFavoriteGalleryPictureSuccess(
        userFavoritePostList: userFavoritePostList);
  }
}
