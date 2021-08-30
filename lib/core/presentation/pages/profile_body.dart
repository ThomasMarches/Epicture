import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:flutter/material.dart';

class UserInformations {
  const UserInformations({
    required this.userName,
    required this.reputation,
    required this.bio,
    required this.reputationName,
    required this.avatar,
  });

  factory UserInformations.fromMap(Map<String, dynamic> map) {
    return UserInformations(
      userName: map['url'],
      reputation: map['reputation'],
      bio: map['bio'],
      reputationName: map['reputation_name'],
      avatar: map['avatar'],
    );
  }

  final String userName;
  final int reputation;
  final String? bio;
  final String reputationName;
  final String? avatar;
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({
    Key? key,
  }) : super(key: key);

  static const routeName = '/searchpage';

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  UserInformations? userInformations;
  List<ImgurImages>? userImagesList;

  @override
  void initState() {
    super.initState();
    ImgurDataSource.getUserInformations(context)
        .then((userInfos) => setState(() {
              userInformations = userInfos;
            }));
    ImgurDataSource.getUserImages(context).then((userImages) => setState(() {
          userImagesList = userImages;
        }));
  }

  @override
  Widget build(BuildContext context) {
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
                        decoration: (userInformations != null &&
                                userInformations!.avatar != null)
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      Image.network(userInformations!.avatar!)
                                          .image,
                                  fit: BoxFit.fill,
                                ))
                            : const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            _getUsername(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(_getReputation()),
                              const Text(
                                ' • ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(_getReputationName()),
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
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 10,
                        ),
                        child: Text(
                          _getBiography(),
                          style: const TextStyle(
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: userImagesList == null ? 0 : userImagesList!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: Image.network(userImagesList![index].link).image,
                        fit: BoxFit.fill,
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getUsername() {
    if (userInformations != null) {
      return userInformations!.userName;
    }
    return 'Username';
  }

  String _getReputationName() {
    if (userInformations != null) {
      return userInformations!.reputationName;
    }
    return 'Neutral';
  }

  String _getBiography() {
    if (userInformations != null && userInformations?.bio != null) {
      return userInformations!.bio!;
    }
    return 'No descritpion.';
  }

  String _getReputation() {
    if (userInformations != null) {
      return userInformations!.reputation.toString();
    }
    return '0';
  }
}
