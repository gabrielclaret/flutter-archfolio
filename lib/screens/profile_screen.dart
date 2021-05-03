import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color mainTheme = Palette.mainColorTheme;
  bool _isTimeline = false;
  User loggedUser;

  @override
  void initState() {
    loggedUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loggedUser != null
        ? Scaffold(
            backgroundColor: Palette.scaffold,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  brightness: Brightness.light,
                  backgroundColor: Palette.cardTheme,
                  title: Text(
                    'profile',
                    style: const TextStyle(
                      color: mainTheme,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.9,
                    ),
                  ),
                  centerTitle: false,
                  floating: true,
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 25.0,
                        color: mainTheme,
                        onPressed: () => print(
                          "Edit Profile",
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: ProfileCard(
                    user: loggedUser,
                    isMiniature: false,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(
                    child: Card(
                      color: Palette.cardTheme,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Posts',
                                style: const TextStyle(
                                  color: mainTheme,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.8,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.dehaze),
                            iconSize: 25.0,
                            color: mainTheme,
                            onPressed: () {
                              setState(() {
                                _isTimeline = true;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.grid_view),
                            iconSize: 25.0,
                            color: mainTheme,
                            onPressed: () {
                              setState(() {
                                _isTimeline = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // loggedUser.posts != null
                //     ? SliverGrid(
                //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //           maxCrossAxisExtent: _isTimeline ? 500 : 300,
                //           mainAxisSpacing: 10.0,
                //           crossAxisSpacing: 10.0,
                //           childAspectRatio: _isTimeline ? 1.1 : 0.95,
                //         ),
                //         delegate: SliverChildBuilderDelegate(
                //           (BuildContext context, int index) {
                //             final Post post = loggedUser.posts[index];

                //             return post != null
                //                 ? PostContainer(post: post)
                //                 : Container();
                //           },
                //           childCount: loggedUser.posts.length,
                //         ),
                //       )
                //     : SizedBox.shrink(),
              ],
            ),
          )
        : Scaffold();
  }
}

Future<User> intantiateUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userString = prefs.getString("user");
  User user;

  user = User.fromJson(jsonDecode(userString));
  print(user.runtimeType);
  print("myuesr");
  print(user.username);
  return user;
}
