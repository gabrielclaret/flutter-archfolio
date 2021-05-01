import 'package:meta/meta.dart';
import 'models.dart';

class User {
  final String name;
  final String imageUrl;
  final String description;
  final String location;
  final String joinDate;
  final String email;
  final List<Post> posts;

  const User({
    @required this.name,
    @required this.imageUrl,
    this.description,
    this.location,
    this.joinDate,
    this.email,
    this.posts,
  });
}
