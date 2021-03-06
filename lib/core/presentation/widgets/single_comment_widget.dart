import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              isAuthor == true
                  ? 'You'
                  : '${widget.imageCommentsList?[widget.index].author}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${widget.imageCommentsList?[widget.index].comment}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Row(
            children: [
              Text(
                Utils.getTimeDifference(
                    widget.imageCommentsList![widget.index].datetime),
                style: const TextStyle(color: Colors.black),
              ),
              const Spacer(),
              if (isAuthor == true)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () async {
                      Utils.showAlertDialog(
                        context,
                        _deleteComment,
                        "Confirm delete",
                        "Would you like to continue and delete your comment ?",
                      );
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
                style: const TextStyle(color: Colors.black),
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
                style: const TextStyle(color: Colors.black),
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
