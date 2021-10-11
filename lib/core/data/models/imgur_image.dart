class ImgurImages {
  const ImgurImages({
    required this.id,
    required this.author,
    required this.title,
    required this.vote,
    required this.width,
    required this.height,
    required this.favorite,
    required this.type,
    required this.description,
    required this.datetime,
    required this.link,
  });

  factory ImgurImages.fromMap(Map<String, dynamic> map) {
    return ImgurImages(
      id: map['id'] as String,
      author: map['account_url'] as String?,
      title: map['title'] as String?,
      width: map['width'] as int,
      height: map['height'] as int,
      vote: map['vote'] as String?,
      favorite: map['favorite'] as bool,
      type: map['type'].toString().substring(6),
      description: map['description'] as String?,
      datetime:
          DateTime.fromMillisecondsSinceEpoch(map['datetime'] * 1000 as int),
      link: map['link'] as String,
    );
  }

  final String id;
  final String? author;
  final String type;
  final int width;
  final int height;
  final String? vote;
  final bool favorite;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String link;
}
