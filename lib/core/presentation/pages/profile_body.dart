import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
  }) : super(key: key);

  static const routeName = '/searchpage';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.grey[300],
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          const Text(
                            'Jad31',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Text('0'),
                              Text(
                                ' • ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text('Neutral'),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          '1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds ' +
                              '2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d ' +
                              '3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs' +
                              '4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad' +
                              '5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds ' +
                              '6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf' +
                              '7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd' +
                              '8 Description that is too long in text format(Here Data is coming from API)' +
                              '9 Description that is too long in text format(Here Data is coming from API)' +
                              '10 Description that is too long in text format(Here Data is coming from API)',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: GridView.count(
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
