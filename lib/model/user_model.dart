import 'package:meta/meta.dart';
import 'models.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String imageUrl;
  final String description;
  final String location;
  final String joined_at;

  const User({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.imageUrl,
    @required this.email,
    this.description,
    this.location,
    this.joined_at,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      imageUrl: json['pfp_url'],
      description: json['description'],
      username: json['username'],
      email: json['email'],
      location: json['location'],
      joined_at: json['joined_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user["id"] = id;
    user["name"] = name;
    user["imageUrl"] = imageUrl;
    user["description"] = description;
    user["email"] = email;
    user["username"] = username;
    user["location"] = location;
    user["joined_at"] = joined_at;
    return user;
  }
}
