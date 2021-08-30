import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/utils/constants.dart';

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

  @override
  void initState() {
    super.initState();
    _getUsernameFromApi(context).then((userInfos) => setState(() {
          userInformations = userInfos;
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
    return """
1 Deslksaf j klkjjflkdsjfkddfdfsdfd +
'2) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d ' +
'3)  adfsfdsfdfsdfdsf   dsf dfd fds fs' +
'4) dsaf dsafdfdfsd dfdsfsda fdas dsad' +
'5) dsfdsfd fdsfds fds fdsf dsfds fds ' +
'6) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf' +
'7) df dsfdsfdsfdsfds df dsfds fds fsd' +
'8 Description coming from API)' +
'9 Description coming from API)' +
'4) dsaf dsafdfdfsd dfdsfsda fdas dsad' +
'5) dsfdsfd fdsfds fds fdsf dsfds fds ' +
'6) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf' +
'7) df dsfdsfdsfdsfds df dsfds fds fsd' +
'10 Descriptios coming from API """;
  }

  String _getReputation() {
    if (userInformations != null) {
      return userInformations!.reputation.toString();
    }
    return '0';
  }

  Future<UserInformations?> _getUsernameFromApi(BuildContext context) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      try {
        var response = await http.get(
            Uri.parse(
                Constants.getUserInformationsURL + state.user.accountUsername),
            headers: {'Authorization': 'Client-ID ${Constants.clientId}'});

        if (response.statusCode != 200) {
          throw (Exception(
              'Error from API call GET /account/username/  Error code: ${response.statusCode}'));
        }

        final jsonResponse = jsonDecode(response.body);
        final jsonData = jsonResponse['data'];

        return UserInformations.fromMap(jsonData);
      } catch (e) {
        print(e);
      }
    }
    return null;
  }
}
