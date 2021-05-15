import 'package:meta/meta.dart';

class Post {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String thumbnail;
  final int likes;
  final int views;

  const Post({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.description,
    @required this.thumbnail,
    @required this.likes,
    @required this.views,
  });
}
