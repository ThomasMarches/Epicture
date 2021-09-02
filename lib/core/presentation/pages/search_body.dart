import 'package:epicture/core/data/models/imgur_image.dart';
import 'package:flutter/material.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';

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
  var hasRequested = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
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
        userAssociatedImageList == null
            ? hasRequested == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Center()
            : Flexible(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
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
                      child: Column(
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
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
