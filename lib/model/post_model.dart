import 'package:meta/meta.dart';

class Post {
  final int id;
  final int userId;
  final String title;
  final String description;
  final int views;
  final String thumbnail;

  const Post({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.description,
    @required this.views,
    @required this.thumbnail
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      views: json['views'],
      thumbnail: json['pfp_url']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> post = Map<String, dynamic>();
    post["id"] = id;
    post["userId"] = userId;
    post["title"] = title;
    post["description"] = description;
    post["views"] = views;
    return post;
  }
}
