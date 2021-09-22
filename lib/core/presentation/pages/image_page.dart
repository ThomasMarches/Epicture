import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/utils/constants.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePageArguments {
  const ImagePageArguments({
    required this.id,
    required this.title,
    required this.vote,
    required this.width,
    required this.height,
    required this.favorite,
    required this.type,
    required this.description,
    required this.datetime,
    required this.section,
    required this.link,
  });

  final String id;
  final String type;
  final int width;
  final int height;
  final String? vote;
  final bool favorite;
  final String? title;
  final String? description;
  final int datetime;
  final String? section;
  final String link;
}

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key, required this.image}) : super(key: key);

  final ImagePageArguments image;
  static const routeName = '/images';

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<ImgurComments>? imageCommentsList;
  final _controller = TextEditingController();

  @override
  void initState() {
    print(widget.image.link);
    super.initState();
    ImgurDataSource.getImageComments(
            context, widget.image.id)
        .then(
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
                  child: Text(
                    widget.image.title == null ? '' : widget.image.title!,
                    style: const TextStyle(fontSize: 15),
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
                      icon: Icon(
                        Icons.comment,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(flex: 3),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_upward_sharp,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
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
                          _getPictureHash(
                            widget.image.link,
                          ),
                        );
                      },
                      icon: Icon(
                        widget.image.favorite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: widget.image.favorite ? Colors.red : Colors.grey,
                      ),
                    )
                  ]),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (String comment) async {
                          _controller.clear();
                          ImgurDataSource.createCommentOnImage(
                            context,
                            _getPictureHash(widget.image.link),
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

  String _getPictureHash(String link) {
    return link.substring(20, link.length - 4);
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
  UserLoadedState? state;
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
          Row(
            children: [
              Text(
                isAuthor == true
                    ? 'Written by: You'
                    : 'Written by: ${widget.imageCommentsList?[widget.index].author}',
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
                  ImgurDataSource.voteOnComment(
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

  void _deleteComment() {
    ImgurDataSource.deleteComment(
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
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      state = userBloc.state as UserLoadedState;
      if (widget.imageCommentsList?[widget.index].author ==
          state?.user.accountUsername) {
        setState(
          () {
            isAuthor = true;
          },
        );
      }
    } else {
      state = null;
    }
  }
}