import 'package:flutter/material.dart';
// import '../../../l10n/l10n.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;

    return Container(
      color: Colors.grey[300],
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
                            const Text('1243'),
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width - 50,
                          height: 500,
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
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width - 50,
                          height: 400,
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
                            const Spacer(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
