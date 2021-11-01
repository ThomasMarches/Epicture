class ImgurComments {
  const ImgurComments({
    required this.id,
    required this.comment,
    required this.vote,
    required this.ups,
    required this.downs,
    required this.author,
    required this.datetime,
  });

  factory ImgurComments.fromMap(Map<String, dynamic> map) {
    return ImgurComments(
      id: map['id'] as int,
      comment: map['comment'] as String,
      ups: map['ups'] as int,
      downs: map['downs'] as int,
      vote: map['vote'] as String?,
      author: map['author'] as String,
      datetime:
          DateTime.fromMillisecondsSinceEpoch(map['datetime'] * 1000 as int),
    );
  }

  final int id;
  final int ups;
  final int downs;
  final String? vote;
  final String author;
  final String comment;
  final DateTime datetime;
}
