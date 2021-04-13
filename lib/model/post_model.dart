import 'package:meta/meta.dart';
import 'models.dart';

class Post {
  final User user;
  final String title;
  final String description;
  final String imageUrl;
  final int likes;
  final int views;

  const Post({
    @required this.user,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.likes,
    @required this.views,
  });
}
