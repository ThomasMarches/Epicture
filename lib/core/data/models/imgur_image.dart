class ImgurImages {
  const ImgurImages({
    required this.id,
    required this.title,
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
      type: map['type'].toString().substring(6),
      description: map['description'],
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
      section: map['section'],
      link: map['link'],
    );
  }

  final String id;
  final String type;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String? section;
  final String link;
}
