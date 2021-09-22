class ImgurProfileImage {
  const ImgurProfileImage({
    required this.id,
    required this.title,
    required this.description,
    required this.datetime,
    required this.type,
    required this.animated,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.vote,
    required this.favorite,
    required this.section,
    required this.accountUrl,
    required this.accountId,
    required this.isAd,
    required this.inMostViral,
    required this.hasSound,
    required this.adType,
    required this.adUrl,
    required this.edited,
    required this.inGallery,
    required this.deletehash,
    required this.name,
    required this.link,
  });

  factory ImgurProfileImage.fromMap(Map<String, dynamic> map) {
    return ImgurProfileImage(
      id: map['id'] as String,
      title: map['title'] as String?,
      description: map['description'] as String?,
      datetime:
          DateTime.fromMillisecondsSinceEpoch(map['datetime'] * 1000 as int),
      type: map['type'] as String,
      animated: map['animated'] as bool,
      width: map['width'] as int,
      height: map['height'] as int,
      size: map['size'] as int,
      views: map['views'] as int,
      vote: map['vote'] as String?,
      favorite: map['favorite'] as bool,
      section: map['section'] as String?,
      accountUrl: map['account_url'] as String,
      accountId: map['account_id'] as int,
      isAd: map['is_ad'] as bool,
      inMostViral: map['in_most_viral'] as bool,
      hasSound: map['has_sound'] as bool,
      adType: map['ad_type'] as int,
      adUrl: map['ad_url'] as String,
      edited: map['edited'] as String,
      inGallery: map['in_gallery'] as bool,
      deletehash: map['deletehash'] as String,
      name: map['name'] as String,
      link: map['link'] as String,
    );
  }

  final String id;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String type;
  final bool animated;
  final int width;
  final int height;
  final int size;
  final int views;
  final String? vote;
  final bool favorite;
  final String? section;
  final String accountUrl;
  final int accountId;
  final bool isAd;
  final bool inMostViral;
  final bool hasSound;
  final int adType;
  final String adUrl;
  final String edited;
  final bool inGallery;
  final String deletehash;
  final String name;
  final String link;
}
