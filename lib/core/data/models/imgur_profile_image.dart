class ImgurProfileImage {
  const ImgurProfileImage({
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
    required this.deletehash,
    required this.name,
    required this.link,
  });

  factory ImgurProfileImage.fromMap(Map<String, dynamic> map) {
    return ImgurProfileImage(
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
      deletehash: map['deletehash'] as String,
      name: map['name'] as String?,
      link: map['link'] as String,
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
  final String deletehash;
  final String? name;
  final String link;
}
