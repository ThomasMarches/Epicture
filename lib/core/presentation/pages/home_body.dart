import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:flutter/material.dart';
// import '../../../l10n/l10n.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  static const routeName = '/homepage';

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<HomePageImages>? homePageImagesList;

  @override
  void initState() {
    super.initState();
    ImgurDataSource.getHomePageImages(context)
        .then((homePageImages) => setState(() {
              homePageImagesList = homePageImages;
            }));
    if (homePageImagesList == null) {
      print('null');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;

    return Container(
      color: Colors.grey[300],
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount:
              homePageImagesList == null ? 0 : homePageImagesList!.length,
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.all(0),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          homePageImagesList![index].title == null
                              ? ''
                              : homePageImagesList![index].title!,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image:
                                  Image.network(homePageImagesList![index].link)
                                      .image,
                              fit: BoxFit.fill),
                        ),
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width - 50,
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline,
                              color: Colors.grey,
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
}
