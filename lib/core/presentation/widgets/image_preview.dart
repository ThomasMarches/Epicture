import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key? key,
    required this.link,
    required this.post,
  }) : super(key: key);

  final ImgurPost post;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: Image.network(link).image,
        fit: BoxFit.fill,
      ),
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width - 50,
    );
  }
}
