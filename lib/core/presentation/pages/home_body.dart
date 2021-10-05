import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
// import '../../../l10n/l10n.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  static const routeName = '/homepage';

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<ImgurImages>? homePageImagesList;
  List<bool>? userLikedPictures;

  @override
  void initState() {
    super.initState();
    ImgurDataSource.getHomePageImages(context).then(
      (homePageImages) => setState(
        () {
          homePageImagesList = homePageImages;
          if (homePageImagesList == null) return;
          userLikedPictures = List.generate(homePageImagesList!.length,
              (index) => homePageImagesList![index].favorite);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return homePageImagesList == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.grey[300],
            child: Align(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                    homePageImagesList == null ? 0 : homePageImagesList!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 5),
                              child: Text(
                                homePageImagesList![index].title == null
                                    ? ''
                                    : homePageImagesList![index].title!,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Utils.moveToImagePage(
                                  homePageImagesList![index].id,
                                  homePageImagesList![index].author,
                                  homePageImagesList![index].type,
                                  homePageImagesList![index].width,
                                  homePageImagesList![index].height,
                                  homePageImagesList![index].vote,
                                  homePageImagesList![index].favorite,
                                  homePageImagesList![index].title,
                                  homePageImagesList![index].description,
                                  homePageImagesList![index].datetime,
                                  homePageImagesList![index].section,
                                  homePageImagesList![index].link,
                                  context,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                    image: Image.network(
                                            homePageImagesList![index].link)
                                        .image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                margin: const EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width - 50,
                                height: homePageImagesList![index]
                                    .height
                                    .toDouble(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                                  homePageImagesList![index].vote == null
                                      ? ''
                                      : homePageImagesList![index].vote!,
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
                                        homePageImagesList![index].type,
                                        homePageImagesList![index].link,
                                      ),
                                    );
                                    setState(() {
                                      userLikedPictures![index] =
                                          !userLikedPictures![index];
                                    });
                                  },
                                  icon: Icon(
                                    userLikedPictures![index]
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: userLikedPictures![index]
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
            ),
          );
  }

  String _getPictureHash(String type, String link) {
    if (type == 'image/jpeg') {
      return link.substring(20, link.length - 5);
    }
    return link.substring(20, link.length - 4);
  }
}
