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
      id: map['id'],
      title: map['title'],
      width: map['width'],
      height: map['height'],
      vote: map['vote'],
      favorite: map['favorite'],
      type: map['type'].toString().substring(6),
      description: map['description'],
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
      section: map['section'],
      link: map['link'],
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
