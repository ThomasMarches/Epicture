import 'package:cached_network_image/cached_network_image.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBody extends StatefulWidget {
  const FavoriteBody({
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteBodyState createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  List<ImgurPost>? userFavoritePostsList;
  List<bool>? userLikedPictures;

  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      BlocProvider.of<FavoriteGalleryBloc>(context).add(
        FetchFavoriteGalleryPictureEvent(
            accessToken: state.user.accessToken,
            accountUsername: state.user.accountUsername),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteGalleryBloc, FavoriteGalleryBlocState>(
      listener: (context, state) {
        if (state is FetchFavoriteGalleryPictureSuccess) {
          setState(() {
            userFavoritePostsList = state.userFavoritePostList;
            userLikedPictures =
                List.generate(userFavoritePostsList!.length, (index) => true);
          });
        }
      },
      builder: (context, state) {
        return (state is FetchFavoriteGalleryPictureSuccess)
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: userFavoritePostsList == null
                    ? 0
                    : userFavoritePostsList!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Card(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              Utils.moveToPreviewPage(
                                userFavoritePostsList![index],
                                context,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  (userFavoritePostsList![index].isAlbum ==
                                              true &&
                                          userFavoritePostsList![index]
                                              .content
                                              .isNotEmpty)
                                      ? userFavoritePostsList![index].content[0]
                                      : userFavoritePostsList![index].link,
                                ),
                                fit: BoxFit.fill,
                              )),
                            ),
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () async {
                              await ImgurDataSource.favoriteAPost(
                                context,
                                userFavoritePostsList![index].id,
                              ).then((value) {
                                if (value == true) {
                                  _notifyFavoriteGalleryBloc(context);
                                  setState(() {
                                    userLikedPictures![index] =
                                        !userLikedPictures![index];
                                  });
                                } else {
                                  Utils.showSnackbar(
                                    context,
                                    'Error: 404 not found',
                                    Colors.red,
                                    const Duration(seconds: 2),
                                  );
                                }
                              });
                            },
                            icon: Icon(
                              userLikedPictures?[index] == true
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _notifyFavoriteGalleryBloc(BuildContext context) {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    BlocProvider.of<FavoriteGalleryBloc>(context).add(
      FetchFavoriteGalleryPictureEvent(
        accessToken: userBlocState.user.accessToken,
        accountUsername: userBlocState.user.accountUsername,
      ),
    );
  }
}
