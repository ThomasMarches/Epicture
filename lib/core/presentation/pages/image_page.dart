import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/bloc/favorite_gallery_bloc/favorite_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/profile_gallery_bloc/profile_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/utils/constants.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePageArguments {
  const ImagePageArguments({
    required this.id,
    required this.author,
    required this.title,
    required this.vote,
    required this.width,
    required this.height,
    required this.favorite,
    required this.type,
    required this.description,
    required this.datetime,
    required this.link,
  });

  final String id;
  final String? author;
  final String type;
  final int width;
  final int height;
  final String? vote;
  final bool favorite;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String link;
}

//TODO: impletement image description
class ImagePage extends StatefulWidget {
  const ImagePage({
    Key? key,
    required this.image,
    this.commentsList,
  }) : super(key: key);

  final List<ImgurComments>? commentsList;
  final ImagePageArguments image;
  static const routeName = '/images';

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<ImgurComments>? imageCommentsList;
  final _controller = TextEditingController();
  var isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.image.favorite;
    if (widget.commentsList != null) {
      setState(
        () {
          imageCommentsList = widget.commentsList;
        },
      );
      return;
    }
    ImgurDataSource.getImageComments(context, widget.image.id).then(
      (value) => setState(
        () {
          imageCommentsList = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.image.author != null &&
              widget.image.author == _getUserUsername(context))
            IconButton(
              onPressed: () {
                showModalSheet(context);
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
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Center(
                    child: Text(
                      widget.image.title == null ? '' : widget.image.title!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: Image.network(widget.image.link).image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width - 50,
                  height: widget.image.height.toDouble(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_upward_sharp,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.image.vote == null ? '' : widget.image.vote!,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_downward_sharp,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(flex: 3),
                    IconButton(
                      onPressed: () async {
                        await ImgurDataSource.favoriteAnImage(
                          context,
                          widget.image.id,
                        ).then((value) {
                          if (value == true) {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            _notifyFavoriteGalleryBloc(context);
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
                  child: Text(
                      'Uploaded: ${Utils.getTimeDifference(widget.image.datetime)}'),
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
                            widget.image.id,
                            comment,
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                imageCommentsList?.insert(0, value);
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
                if (imageCommentsList != null)
                  ImageCommentList(imageCommentsList: imageCommentsList)
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

  Future<dynamic> showModalSheet(BuildContext context) {
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
                    await ImgurDataSource.deleteImage(context, widget.image.id)
                        .then((value) {
                      if (value == true) {
                        _notifyProfileGalleryBloc(context);
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

  void _notifyProfileGalleryBloc(BuildContext context) {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    BlocProvider.of<ProfileGalleryBloc>(context).add(
      FetchProfileGalleryPictureEvent(
        accessToken: userBlocState.user.accessToken,
      ),
    );
  }

  String _getUserUsername(BuildContext context) {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    return userBlocState.user.accountUsername;
  }
}

class ImageCommentList extends StatefulWidget {
  const ImageCommentList({
    Key? key,
    required this.imageCommentsList,
  }) : super(key: key);

  final List<ImgurComments>? imageCommentsList;

  @override
  State<ImageCommentList> createState() => _ImageCommentListState();
}

class _ImageCommentListState extends State<ImageCommentList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: widget.imageCommentsList?.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleCommentWidget(
            imageCommentsList: widget.imageCommentsList,
            index: index,
            updateImageList: _updateImageList,
          );
        });
  }

  void _updateImageList(int index) {
    setState(() {
      widget.imageCommentsList!.removeAt(index);
    });
  }
}

class SingleCommentWidget extends StatefulWidget {
  const SingleCommentWidget({
    Key? key,
    required this.imageCommentsList,
    required this.updateImageList,
    required this.index,
  }) : super(key: key);

  final List<ImgurComments>? imageCommentsList;
  final void Function(int) updateImageList;
  final int index;

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  var hasUpVoted = false;
  var hasDownVoted = false;
  bool isAuthor = false;

  @override
  Widget build(BuildContext context) {
    _setupIsAuthor(context);

    if (widget.imageCommentsList![widget.index].vote != null) {
      hasUpVoted =
          widget.imageCommentsList![widget.index].vote == 'up' ? true : false;
      hasDownVoted =
          widget.imageCommentsList![widget.index].vote == 'down' ? true : false;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      height: 150,
      color: Colors.grey[200],
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${widget.imageCommentsList?[widget.index].comment}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              isAuthor == true
                  ? 'Written by: You'
                  : 'Written by: ${widget.imageCommentsList?[widget.index].author}',
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
          Row(
            children: [
              Text(
                'Uploaded: ${Utils.getTimeDifference(widget.imageCommentsList![widget.index].datetime)}',
                style: const TextStyle(color: Colors.black, fontSize: 10),
              ),
              const Spacer(),
              if (isAuthor == true)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () async {
                      Utils.showAlertDialog(context, _deleteComment);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                ),
              IconButton(
                onPressed: () async {
                  ImgurDataSource.voteOnComment(
                          context,
                          widget.imageCommentsList![widget.index].id.toString(),
                          'up')
                      .then(
                    (value) {
                      if (value == true) {
                        setState(() {
                          hasUpVoted = true;
                          hasDownVoted = false;
                        });
                      }
                    },
                  );
                },
                icon: Icon(
                  Icons.arrow_upward_sharp,
                  color: hasUpVoted == true ? Colors.red : Colors.grey,
                ),
              ),
              Text(
                '${widget.imageCommentsList?[widget.index].ups}',
                style: const TextStyle(color: Colors.black, fontSize: 10),
              ),
              IconButton(
                onPressed: () async {
                  await ImgurDataSource.voteOnComment(
                          context,
                          widget.imageCommentsList![widget.index].id.toString(),
                          'down')
                      .then(
                    (value) {
                      if (value == true) {
                        setState(() {
                          hasUpVoted = false;
                          hasDownVoted = true;
                        });
                      }
                    },
                  );
                },
                icon: Icon(
                  Icons.arrow_downward_sharp,
                  color: hasDownVoted == true ? Colors.red : Colors.grey,
                ),
              ),
              Text(
                '${widget.imageCommentsList?[widget.index].downs}',
                style: const TextStyle(color: Colors.black, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteComment() async {
    await ImgurDataSource.deleteComment(
            context, widget.imageCommentsList![widget.index].id.toString())
        .then(
      (value) {
        if (value == true) {
          setState(() {
            hasUpVoted = false;
            hasDownVoted = false;
            isAuthor = false;
          });
          widget.updateImageList(widget.index);
        }
      },
    );
  }

  void _setupIsAuthor(BuildContext context) {
    final userBlocState =
        BlocProvider.of<UserBloc>(context).state as UserLoadedState;
    if (widget.imageCommentsList?[widget.index].author ==
        userBlocState.user.accountUsername) {
      setState(
        () {
          isAuthor = true;
        },
      );
    }
  }
}
