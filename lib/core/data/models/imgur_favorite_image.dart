class ImgurFavoriteImage {
  const ImgurFavoriteImage({
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
    required this.inMostViral,
    required this.hasSound,
    required this.tags,
    required this.inGallery,
    required this.link,
    required this.cover,
  });

  factory ImgurFavoriteImage.fromMap(Map<String, dynamic> map) {
    final cover = map['cover'];
    final type = map['type'].toString().substring(6);

    return ImgurFavoriteImage(
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
      inMostViral: map['in_most_viral'],
      hasSound: map['has_sound'],
      tags: map['tags'] == null ? null : List.from(map['tags']),
      inGallery: map['in_gallery'],
      cover: map['cover'],
      link: 'https://i.imgur.com/$cover.$type',
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
  final bool inMostViral;
  final bool hasSound;
  final List? tags;
  final bool inGallery;
  final String link;
  final String cover;
}
