import 'package:epicture/core/data/models/imgur_profile_image.dart';
import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:epicture/core/presentation/bloc/profile_gallery_bloc/profile_gallery_bloc.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:epicture/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      userName: map['url'] as String,
      reputation: map['reputation'] as int,
      bio: map['bio'] as String?,
      reputationName: map['reputation_name'] as String,
      avatar: map['avatar'] as String?,
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
  List<ImgurProfileImage>? userImagesList;

  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<UserBloc>(context);
    if (userBloc.state is UserLoadedState) {
      final state = userBloc.state as UserLoadedState;
      BlocProvider.of<ProfileGalleryBloc>(context).add(
        FetchProfileGalleryPictureEvent(accessToken: state.user.accessToken),
      );
    }
    ImgurDataSource.getUserInformations(context)
        .then((userInfos) => setState(() {
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
            borderRadius: BorderRadius.circular(40),
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
          BlocConsumer<ProfileGalleryBloc, ProfileGalleryBlocState>(
            listener: (context, state) {
              if (state is FetchProfileGalleryPictureSuccess) {
                setState(() {
                  userImagesList = state.userImagesList;
                });
              }
            },
            builder: (context, state) {
              if (state is FetchProfileGalleryPictureSuccess) {
                return Flexible(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount:
                        userImagesList == null ? 0 : userImagesList!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {
                          Utils.moveToImagePage(
                            userImagesList![index].id,
                            userImagesList![index].type,
                            userImagesList![index].width,
                            userImagesList![index].height,
                            userImagesList![index].vote,
                            userImagesList![index].favorite,
                            userImagesList![index].title,
                            userImagesList![index].description,
                            userImagesList![index].datetime,
                            userImagesList![index].section,
                            userImagesList![index].link,
                            context,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: Image.network(userImagesList![index].link)
                                .image,
                            fit: BoxFit.fill,
                          )),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is FetchProfileGalleryPictureLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Text('Couldn\'t load your profile pictures');
              }
            },
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
