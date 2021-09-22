class ImgurImages {
  const ImgurImages({
    required this.id,
    required this.title,
    required this.vote,
    required this.width,
    required this.height,
    required this.favorite,
    required this.type,
    required this.description,
    required this.datetime,
    required this.section,
    required this.link,
  });

  factory ImgurImages.fromMap(Map<String, dynamic> map) {
    return ImgurImages(
      id: map['id'] as String,
      title: map['title'] as String?,
      width: map['width'] as int,
      height: map['height'] as int,
      vote: map['vote'] as String?,
      favorite: map['favorite'] as bool,
      type: map['type'].toString().substring(6),
      description: map['description'] as String?,
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime'] * 1000 as int),
      section: map['section'] as String?,
      link: map['link'] as String,
    );
  }

  final String id;
  final String type;
  final int width;
  final int height;
  final String? vote;
  final bool favorite;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String? section;
  final String link;
}
