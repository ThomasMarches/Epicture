import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/profile_gallery_bloc/profile_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/presentation/widgets/image_comments_list.dart';
import 'package:epicture/core/presentation/widgets/post_preview.dart';
import 'package:epicture/core/utils/constants.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewPageArguments {
  const PreviewPageArguments({
    required this.post,
  });

  final ImgurPost post;
}

class PreviewPage extends StatefulWidget {
  const PreviewPage({
    Key? key,
    required this.arguments,
    this.commentsList,
  }) : super(key: key);

  final List<ImgurComments>? commentsList;
  final PreviewPageArguments arguments;
  static const routeName = '/images';

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  List<ImgurComments>? commentsList;
  final _controller = TextEditingController();
  var isFavorite = false;
  String? vote;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.arguments.post.favorite;
    vote = widget.arguments.post.vote;
    if (widget.commentsList != null) {
      setState(
        () {
          commentsList = widget.commentsList;
        },
      );
    } else {
      ImgurDataSource.getPostComments(context, widget.arguments.post.id).then(
        (value) => setState(
          () {
            commentsList = value;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.arguments.post.author != null &&
              widget.arguments.post.author == _getUserUsername())
            IconButton(
              onPressed: () {
                showModalSheet();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
        ],
        elevation: 5,
        leading: IconButton(
          color: Colors.black,
          iconSize: 40,
          icon: const Icon(Icons.keyboard_arrow_left),
          tooltip: 'Go back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Epicture',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: Constants.epictureTextGradient,
              ).createShader(
                const Rect.fromLTWH(0, 0, 200, 70),
              ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.zero,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                if (widget.arguments.post.title != null)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 5, left: 5, right: 5),
                    child: Center(
                      child: Text(
                        widget.arguments.post.title!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                PostPreview(post: widget.arguments.post),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(children: [
                    if (widget.arguments.post.ups != null)
                      Text(widget.arguments.post.ups!.toString()),
                    IconButton(
                      onPressed: () async {
                        await _voteForImage(vote, 'up').then((value) {
                          if (value) {
                            setState(() {
                              vote = 'up';
                            });
                          }
                        });
                      },
                      icon: Icon(
                        Icons.arrow_upward_sharp,
                        color: (vote != null && vote == 'up')
                            ? Colors.red
                            : Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    if (widget.arguments.post.downs != null)
                      Text(widget.arguments.post.downs!.toString()),
                    IconButton(
                      onPressed: () async {
                        await _voteForImage(vote, 'down').then((value) {
                          if (value) {
                            setState(() {
                              vote = 'down';
                            });
                          }
                        });
                      },
                      icon: Icon(
                        Icons.arrow_downward_sharp,
                        color: (vote != null && vote == 'down')
                            ? Colors.red
                            : Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Text(widget.arguments.post.views.toString()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        await ImgurDataSource.favoriteAPost(
                          context,
                          widget.arguments.post.id,
                        ).then((value) {
                          if (value == true) {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            _notifyFavoriteGalleryBloc();
                          } else {
                            Utils.showSnackbar(
                              context,
                              'Couldn\'t perform request',
                              Colors.red,
                              const Duration(seconds: 2),
                            );
                          }
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((widget.arguments.post.description != null)
                      ? widget.arguments.post.description!
                      : 'No description.'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Uploaded: ${Utils.getTimeDifference(widget.arguments.post.datetime)}'),
                ),
                if (widget.arguments.post.author != null &&
                    widget.arguments.post.author != '')
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Uploaded by: ${widget.arguments.post.author}'),
                  ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (String comment) async {
                          _controller.clear();
                          await ImgurDataSource.createCommentOnImage(
                            context,
                            widget.arguments.post.id,
                            comment,
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                commentsList?.insert(0, value);
                              });
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Put a comment',
                        ),
                      ),
                    ),
                  ],
                ),
                if (commentsList != null)
                  ImageCommentList(imageCommentsList: commentsList)
                else
                  Center(
                    child: Text(
                      'No comment yet.',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _voteForImage(String? actualVote, String newVote) async {
    return await ImgurDataSource.voteForAlbum(
      context,
      widget.arguments.post.id,
      (actualVote != null && actualVote == newVote) ? 'veto' : newVote,
    );
  }

  Future<dynamic> showModalSheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete picture'),
                  onTap: () async {
                    await ImgurDataSource.deletePost(
                            context, widget.arguments.post.id)
                        .then((value) {
                      if (value == true) {
                        _notifyProfileGalleryBloc();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Utils.showSnackbar(
                          context,
                          'Couldn\'t perform request',
                          Colors.red,
                          const Duration(seconds: 2),
                        );
                      }
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit title'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit description'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _notifyFavoriteGalleryBloc() {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    BlocProvider.of<FavoriteGalleryBloc>(context).add(
      FetchFavoriteGalleryPictureEvent(
        accessToken: userBlocState.user.accessToken,
        accountUsername: userBlocState.user.accountUsername,
      ),
    );
  }

  void _notifyProfileGalleryBloc() {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    BlocProvider.of<ProfileGalleryBloc>(context).add(
      FetchProfileGalleryPictureEvent(
        accessToken: userBlocState.user.accessToken,
      ),
    );
  }

  String _getUserUsername() {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    return userBlocState.user.accountUsername;
  }
}
