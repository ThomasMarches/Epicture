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
    required this.inGallery,
    required this.link,
    required this.cover,
  });

  factory ImgurFavoriteImage.fromMap(Map<String, dynamic> map) {
    final cover = map['cover'] as String;
    final type = map['type'].toString().substring(6);

    return ImgurFavoriteImage(
      id: map['id'] as String,
      title: map['title'] as String?,
      description: map['description'] as String?,
      datetime: map['datetime'] as int,
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
      inMostViral: map['in_most_viral'] as bool,
      hasSound: map['has_sound'] as bool,
      inGallery: map['in_gallery'] as bool,
      cover: map['cover'] as String,
      link: 'https://i.imgur.com/$cover.$type',
    );
  }

  final String id;
  final String? title;
  final String? description;
  final int datetime;
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
  final bool inGallery;
  final String link;
  final String cover;
}
