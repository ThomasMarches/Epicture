import 'package:carousel_slider/carousel_slider.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/presentation/widgets/image_preview.dart';
import 'package:flutter/material.dart';

class PostPreview extends StatelessWidget {
  const PostPreview({Key? key, required this.post}) : super(key: key);

  final ImgurPost post;

  @override
  Widget build(BuildContext context) {
    return (post.isAlbum && post.content.length > 1)
        ? CarouselSlider.builder(
            options: CarouselOptions(
              enlargeCenterPage: true,
            ),
            itemCount: post.content.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return ImagePreview(
                post: post,
                link: post.content[itemIndex],
              );
            })
        : (post.content.length == 1)
            ? ImagePreview(
                post: post,
                link: post.content[0],
              )
            : ImagePreview(
                post: post,
                link: post.link,
              );
  }
}
