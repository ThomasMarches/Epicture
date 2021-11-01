import 'package:cached_network_image/cached_network_image.dart';
import 'package:epicture/core/data/models/imgur_post.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/widgets/drop_down_menu.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  List<ImgurPost>? userAssociatedPostList;
  var hasRequested = false;
  var sort = 'time';
  var window = 'all';
  String? tagValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 5,
          ),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
            onSubmitted: (value) async {
              tagValue = value;
              _updatePostList();
            },
            maxLength: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              DropDownMenu(
                callback: (String? newValue) {
                  if (newValue != null) {
                    sort = newValue;
                    _updatePostList();
                  }
                },
                optionList: const ['time', 'viral', 'top'],
              ),
              const SizedBox(width: 10),
              DropDownMenu(
                callback: (String? newValue) {
                  if (newValue != null) {
                    window = newValue;
                    _updatePostList();
                  }
                },
                optionList: const ['all', 'year', 'month', 'week', 'day'],
              ),
            ],
          ),
        ),
        if (userAssociatedPostList == null && hasRequested == true)
          const CircularProgressIndicator()
        else if (userAssociatedPostList != null &&
            userAssociatedPostList!.isEmpty)
          const Center(
            child: Text("No pictures found."),
          )
        else
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: userAssociatedPostList == null
                  ? 0
                  : userAssociatedPostList!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Utils.moveToPreviewPage(
                              userAssociatedPostList![index],
                              context,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                (userAssociatedPostList![index].isAlbum ==
                                            true &&
                                        userAssociatedPostList![index]
                                            .content
                                            .isNotEmpty)
                                    ? userAssociatedPostList![index].content[0]
                                    : userAssociatedPostList![index].link,
                              ),
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

  void _updatePostList() async {
    setState(() {
      hasRequested = true;
      userAssociatedPostList = null;
    });
    await ImgurDataSource.searchForPosts(tagValue, sort, window).then(
      (userPostList) => setState(
        () {
          userAssociatedPostList = userPostList;
          hasRequested = false;
        },
      ),
    );
  }
}
