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
  List<bool>? userLikedPictures;

  @override
  void initState() {
    super.initState();
    ImgurDataSource.getUserFavoriteImages(context)
        .then((userFavoritesImages) => setState(() {
              userFavoriteImagesList = userFavoritesImages;
              userLikedPictures = List.generate(
                  userFavoriteImagesList!.length, (index) => true);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount:
          userFavoriteImagesList == null ? 0 : userFavoriteImagesList!.length,
      itemBuilder: (BuildContext ctx, index) {
        return Card(
          child: Column(
            children: [
              Flexible(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          userFavoriteImagesList![index].link,
                        ),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      userLikedPictures![index] = !userLikedPictures![index];
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
    );
  }
}
