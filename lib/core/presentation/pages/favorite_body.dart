import 'package:flutter/material.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({
    Key? key,
  }) : super(key: key);

  static const routeName = '/favoritepage';

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 2,
      children: _getImageList(context),
    );
  }

  List<Widget> _getImageList(BuildContext context) {
    return <Widget>[
      Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        // ! changed to SizedBox for code formatting but needs be checked
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Titre de l\'image',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.all(5),
                width: (MediaQuery.of(context).size.width / 3),
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(children: [
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
    ];
  }
}
