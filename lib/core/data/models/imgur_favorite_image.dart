class ImgurFavoriteImage {
  const ImgurFavoriteImage({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.datetime,
    required this.type,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.vote,
    required this.favorite,
    required this.accountUrl,
    required this.accountId,
    required this.link,
    required this.cover,
  });

  factory ImgurFavoriteImage.fromMap(Map<String, dynamic> map) {
    final cover = map['cover'] as String;
    final type = map['type'].toString().substring(6);

    return ImgurFavoriteImage(
      id: map['id'] as String,
      author: map['account_url'] as String?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      datetime:
          DateTime.fromMillisecondsSinceEpoch(map['datetime'] * 1000 as int),
      type: map['type'] as String,
      width: map['width'] as int,
      height: map['height'] as int,
      size: map['size'] as int,
      views: map['views'] as int,
      vote: map['vote'] as String?,
      favorite: map['favorite'] as bool,
      accountUrl: map['account_url'] as String,
      accountId: map['account_id'] as int,
      cover: map['cover'] as String,
      link: 'https://i.imgur.com/$cover.$type',
    );
  }

  final String id;
  final String? author;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String type;
  final int width;
  final int height;
  final int size;
  final int views;
  final String? vote;
  final bool favorite;
  final String accountUrl;
  final int accountId;
  final String link;
  final String cover;
}
