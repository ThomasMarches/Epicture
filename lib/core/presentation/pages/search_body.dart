import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({
    Key? key,
  }) : super(key: key);

  static const routeName = '/searchpage';

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  List<ImgurImages>? userAssociatedImageList;
  bool hasRequested = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
            onSubmitted: (value) {
              setState(() {
                hasRequested = true;
              });
              ImgurDataSource.getUserAssociatedImages(context, value).then(
                (userImagesList) => setState(
                  () {
                    userAssociatedImageList = userImagesList;
                    hasRequested = false;
                  },
                ),
              );
            },
            maxLength: 20,
          ),
        ),
        if (userAssociatedImageList == null)
          hasRequested == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Center()
        else
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: userAssociatedImageList == null
                  ? 0
                  : userAssociatedImageList!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Utils.moveToImagePage(
                              userAssociatedImageList![index].id,
                              userAssociatedImageList![index].type,
                              userAssociatedImageList![index].width,
                              userAssociatedImageList![index].height,
                              userAssociatedImageList![index].vote,
                              userAssociatedImageList![index].favorite,
                              userAssociatedImageList![index].title,
                              userAssociatedImageList![index].description,
                              userAssociatedImageList![index].datetime,
                              userAssociatedImageList![index].section,
                              userAssociatedImageList![index].link,
                              context,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: Image.network(
                                userAssociatedImageList![index].link,
                                loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress,
                                ) {
                                  return Center(
                                    child: child,
                                  );
                                },
                              ).image,
                              fit: BoxFit.fill,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
