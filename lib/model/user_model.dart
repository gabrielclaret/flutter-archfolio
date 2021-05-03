import 'package:meta/meta.dart';
import 'models.dart';

class User {
  final String name;
  final String username;
  final String email;
  final String imageUrl;
  final String description;
  final String location;
  final String joined_at;
  final List<Post> posts;

  const User({
    @required this.name,
    @required this.username,
    @required this.imageUrl,
    @required this.email,
    this.description,
    this.location,
    this.joined_at,
    this.posts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      imageUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
      description: "description",
      username: json['username'],
      email: json['email'],
      location: "brasil",
      joined_at: json['joined_at'],
      posts: json['posts'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user["name"] = name;
    user["imageUrl"] = imageUrl;
    user["description"] = description;
    user["email"] = email;
    user["username"] = username;
    user["location"] = location;
    user["joined_at"] = joined_at;
    user["posts"] = posts;
    return user;
  }
}
