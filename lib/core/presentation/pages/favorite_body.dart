import 'package:epicture/core/data/models/imgur_favorite_image.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoriteBody extends StatefulWidget {
  const FavoriteBody({
    Key? key,
  }) : super(key: key);

  static const routeName = '/favoritepage';

  @override
  _FavoriteBodyState createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  List<ImgurFavoriteImage>? userFavoriteImagesList;

  @override
  void initState() {
    super.initState();
    ImgurDataSource.getUserFavoriteImages(context)
        .then((userFavoritesImages) => setState(() {
              userFavoriteImagesList = userFavoritesImages;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount:
          userFavoriteImagesList == null ? 0 : userFavoriteImagesList!.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  userFavoriteImagesList![index].link,
                ),
                fit: BoxFit.fill,
              )),
        );
      },
    );
  }
}
