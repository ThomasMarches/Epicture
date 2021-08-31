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
    required this.tags,
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
      id: map['id'],
      title: map['title'],
      description: map['description'],
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
      type: map['type'],
      animated: map['animated'],
      width: map['width'],
      height: map['height'],
      size: map['size'],
      views: map['views'],
      vote: map['vote'],
      favorite: map['favorite'],
      section: map['section'],
      accountUrl: map['account_url'],
      accountId: map['account_id'],
      isAd: map['is_ad'],
      inMostViral: map['in_most_viral'],
      hasSound: map['has_sound'],
      tags: map['tags'] == null ? null : List.from(map['tags']),
      adType: map['ad_type'],
      adUrl: map['ad_url'],
      edited: map['edited'],
      inGallery: map['in_gallery'],
      deletehash: map['deletehash'],
      name: map['name'],
      link: map['link'],
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
  final List? tags;
  final int adType;
  final String adUrl;
  final String edited;
  final bool inGallery;
  final String deletehash;
  final String name;
  final String link;
}
