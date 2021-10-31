import 'package:epicture/core/data/models/imgur_comments.dart';
import 'package:epicture/core/presentation/widgets/single_comment_widget.dart';
import 'package:flutter/material.dart';

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
