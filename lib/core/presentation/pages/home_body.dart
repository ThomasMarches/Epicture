import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/widgets/post_preview.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../l10n/l10n.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key, this.homePagePostList}) : super(key: key);

  final List<ImgurPost>? homePagePostList;

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<ImgurPost>? postList;
  List<bool>? likedPosts;

  @override
  void initState() {
    super.initState();
    _setupHomePagePostList();
  }

  void _setupHomePagePostList() async {
    postList = (widget.homePagePostList == null)
        ? await ImgurDataSource.getHomePagePosts(context)
        : widget.homePagePostList;
    if (postList != null) {
      setState(() {
        likedPosts = List.generate(
          postList!.length,
          (index) => postList![index].favorite,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return postList == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.grey[300],
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: postList!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 7.5),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.5))),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          if (postList![index].title != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 5, left: 5, right: 5),
                              child: Text(
                                postList![index].title!,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          InkWell(
                              onTap: () {
                                Utils.moveToPreviewPage(
                                    postList![index], context);
                              },
                              child: PostPreview(post: postList![index])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(children: [
                              Text(postList![index].commentCount.toString()),
                              const SizedBox(width: 5),
                              const Icon(Icons.comment, color: Colors.grey),
                              const Spacer(),
                              Text((postList![index].ups! -
                                      postList![index].downs!)
                                  .toString()),
                              const SizedBox(width: 5),
                              const Icon(Icons.arrow_upward_sharp,
                                  color: Colors.grey),
                              const Spacer(),
                              Text(postList![index].views.toString()),
                              const SizedBox(width: 5),
                              const Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.grey),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  await ImgurDataSource.favoriteAPost(
                                    context,
                                    postList![index].id,
                                  ).then((value) {
                                    if (value == true) {
                                      _notifyFavoriteGalleryBloc(context);
                                      setState(() {
                                        likedPosts![index] =
                                            !likedPosts![index];
                                      });
                                    }
                                  });
                                },
                                icon: Icon(
                                  likedPosts![index]
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: likedPosts![index]
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
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
