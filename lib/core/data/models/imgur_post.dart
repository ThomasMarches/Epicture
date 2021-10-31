class ImgurPost {
  const ImgurPost({
    required this.id,
    required this.author,
    required this.title,
    required this.vote,
    required this.favorite,
    required this.type,
    required this.description,
    required this.datetime,
    required this.link,
    required this.ups,
    required this.downs,
    required this.views,
    required this.isAlbum,
    required this.content,
    required this.commentCount,
  });

  factory ImgurPost.fromMap(Map<String, dynamic> map) {
    List<String> content = [];
    String? link;

    if (map['is_album'] == true) {
      if (map['images'] != null) {
        final itemList = map['images'];
        itemList.forEach((gallery) {
          content.add(gallery['link']);
        });
      } else {
        final type = map['type'].toString().substring(6);
        link = 'https://i.imgur.com/${map['cover']}.$type';
      }
    }

    return ImgurPost(
      id: map['id'] as String,
      author: map['account_url'] as String?,
      title: map['title'] as String?,
      ups: map['ups'] as int?,
      downs: map['downs'] as int?,
      views: map['views'] as int,
      vote: map['vote'] as String?,
      favorite: map['favorite'] as bool,
      commentCount: map['comment_count'] as int?,
      type: (map['is_album'] == true)
          ? null
          : map['type'].toString().substring(6),
      description: map['description'] as String?,
      datetime:
          DateTime.fromMillisecondsSinceEpoch(map['datetime'] * 1000 as int),
      link: (link == null) ? map['link'] as String : link,
      isAlbum: map['is_album'] as bool,
      content: content,
    );
  }

  final String id;
  final String? author;
  final String? type;
  final String? vote;
  final bool favorite;
  final String? title;
  final String? description;
  final DateTime datetime;
  final String link;
  final int? ups;
  final int? downs;
  final int views;
  final int? commentCount;
  final bool isAlbum;
  final List<String> content;
}
