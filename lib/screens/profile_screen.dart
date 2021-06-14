import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/screens/edit_profile_screen.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final User user;
  final bool isEdit;
  const ProfileScreen({Key key, this.user, this.isEdit = true})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.scaffold,
        body: Responsive(
          desktop: _ProfileScreenDesktop(
            isEdit: widget.isEdit,
            user: widget.user,
          ),
          mobile: _ProfileScreenMobile(
            isEdit: widget.isEdit,
            user: widget.user,
          ),
        ));
  }
}

Widget _showPosts(User loggedUser, bool isTimeline, List<Post> userPosts) {
  return isTimeline
      ? SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            childAspectRatio: 1.1,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final Post post = userPosts[index];
              return PostContainer(post: post, showStats: false);
            },
            childCount: userPosts.length,
          ),
        )
      : SliverStaggeredGrid.countBuilder(
          crossAxisCount: 4,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          itemCount: userPosts.length,
          itemBuilder: (BuildContext context, int index) {
            final Post post = userPosts[index];
            return PostContainer(post: post, showStats: false);
          },
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 3 : 2),
        );
}

class _ProfileScreenDesktop extends StatefulWidget {
  final User user;
  final bool isEdit;
  const _ProfileScreenDesktop({Key key, this.user, this.isEdit})
      : super(key: key);

  @override
  __ProfileScreenDesktopState createState() => __ProfileScreenDesktopState();
}

class __ProfileScreenDesktopState extends State<_ProfileScreenDesktop> {
  static const Color mainTheme = Palette.mainColorTheme;
  bool _isTimeline = false;
  User loggedUser;
  bool edit = true;
  Future<List<dynamic>> contents;
  Future<List<Post>> futurePosts;
  int userId;

  static String username;

  Future<List<Post>> _fetchPosts() async {
    List<Post> posts = [];
    Completer<List<Post>> completer = Completer();
    bool noPosts = false;

    var dio = Dio();
    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

    var response = await dio.get('/posts?author=$userId').catchError((e) {
      noPosts = true;
    });
    if (noPosts) {
      return completer.future;
    }
    if (response.statusCode == 200) {
      for (var resp in response.data) {
        Post myPost = Post.fromJson(jsonDecode(jsonEncode(resp)));
        posts.add(myPost);
      }

      completer.complete(posts);
      setState(() {
        futurePosts = completer.future;
      });

      return completer.future;
    } else {
      print('Failed to load posts');
      return null;
    }
  }

  Future<void> _pullRefresh() async {
    var dio = Dio();
    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();
    int userId = loggedUser.id;
    var response = await dio.get('/users?id=$userId');

    User new_user = User.fromJson(jsonDecode(response.data[0].toString()));
    setState(() {
      loggedUser = new_user;
    });
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final new_user = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProfileScreen(
                loggedUser: loggedUser,
              )),
    );
    setState(() {
      loggedUser = new_user;
    });
  }

  @override
  void initState() {
    futurePosts = _fetchPosts();
    edit = widget.isEdit;
    userId = widget.user.id;
    loggedUser = widget.user;
    username = widget.user.username;
    super.initState();
    futurePosts = _fetchPosts();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: FutureBuilder<List<Post>>(
        builder: (context, contentSnap) {
          if (contentSnap.hasData) {
            List<Post> userPosts = contentSnap.data;
            return Center(
              child: Card(
                child: Container(
                  width: size.width * 0.65,
                  height: double.infinity,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        iconTheme: IconThemeData(
                          color: Palette.iconTheme,
                        ),
                        shadowColor: Colors.transparent,
                        brightness: Brightness.light,
                        backgroundColor: Palette.cardTheme,
                        title: Text(
                          '@$username',
                          key: const Key('profileScreenText'),
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
                          edit
                              ? Container(
                                  margin: const EdgeInsets.all(6.0),
                                  child: IconButton(
                                    key: const Key('editProfileButton'),
                                    icon: Icon(Icons.edit),
                                    iconSize: 25.0,
                                    color: mainTheme,
                                    onPressed: () =>
                                        _navigateAndDisplaySelection(context),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: ProfileCard(
                          user: loggedUser,
                          isMiniature: false,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        sliver: SliverToBoxAdapter(
                          child: Card(
                            color: Palette.cardTheme,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
                                !_isTimeline
                                    ? IconButton(
                                        icon: Icon(Icons.dehaze),
                                        iconSize: 25.0,
                                        color: mainTheme,
                                        onPressed: () {
                                          setState(() {
                                            _isTimeline = true;
                                          });
                                        },
                                      )
                                    : IconButton(
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
                      userPosts.isEmpty
                          ? SliverToBoxAdapter(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Center(
                                      child: Text(
                                    "User doesn't have posts yet.",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      letterSpacing: -0.8,
                                    ),
                                  )),
                                ),
                              ),
                            )
                          : _showPosts(loggedUser, _isTimeline, userPosts),
                    ],
                  ),
                ),
              ),
            );
          } else if (contentSnap.hasError) {
            return Text("${contentSnap.error}");
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: Palette.iconTheme,
                ),
                shadowColor: Colors.transparent,
                brightness: Brightness.light,
                backgroundColor: Palette.cardTheme,
                title: Text(
                  'profile of @$username',
                  key: const Key('profileScreenText'),
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
                  edit
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: IconButton(
                            key: const Key('editProfileButton'),
                            icon: Icon(Icons.edit),
                            iconSize: 25.0,
                            color: mainTheme,
                            onPressed: () =>
                                _navigateAndDisplaySelection(context),
                          ),
                        )
                      : Container(),
                ],
              ),
              SliverToBoxAdapter(
                child: ProfileCard(
                  user: loggedUser,
                  isMiniature: false,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
                        !_isTimeline
                            ? IconButton(
                                icon: Icon(Icons.dehaze),
                                iconSize: 25.0,
                                color: mainTheme,
                                onPressed: () {
                                  setState(() {
                                    _isTimeline = true;
                                  });
                                },
                              )
                            : IconButton(
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
            ],
          );
        },
        future: futurePosts,
      ),
    );
  }
}

class _ProfileScreenMobile extends StatefulWidget {
  final User user;
  final bool isEdit;
  const _ProfileScreenMobile({Key key, this.user, this.isEdit})
      : super(key: key);

  @override
  __ProfileScreenMobileState createState() => __ProfileScreenMobileState();
}

class __ProfileScreenMobileState extends State<_ProfileScreenMobile> {
  static const Color mainTheme = Palette.mainColorTheme;
  bool _isTimeline = false;
  User loggedUser;
  bool edit = true;
  Future<List<dynamic>> contents;
  Future<List<Post>> futurePosts;
  int userId;

  static String username;

  Future<List<Post>> _fetchPosts() async {
    List<Post> posts = [];
    Completer<List<Post>> completer = Completer();
    bool noPosts = false;

    var dio = Dio();
    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

    var response = await dio.get('/posts?author=$userId').catchError((e) {
      noPosts = true;
    });
    if (noPosts) {
      return completer.future;
    }
    if (response.statusCode == 200) {
      for (var resp in response.data) {
        Post myPost = Post.fromJson(jsonDecode(jsonEncode(resp)));
        posts.add(myPost);
      }

      completer.complete(posts);
      setState(() {
        futurePosts = completer.future;
      });

      return completer.future;
    } else {
      print('Failed to load posts');
      return null;
    }
  }

  Future<void> _pullRefresh() async {
    var dio = Dio();
    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();
    int userId = loggedUser.id;
    var response = await dio.get('/users?id=$userId');

    User new_user = User.fromJson(jsonDecode(response.data[0].toString()));
    setState(() {
      loggedUser = new_user;
    });
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final new_user = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProfileScreen(
                loggedUser: loggedUser,
              )),
    );
    setState(() {
      loggedUser = new_user;
    });
  }

  @override
  void initState() {
    futurePosts = _fetchPosts();
    edit = widget.isEdit;
    userId = widget.user.id;
    loggedUser = widget.user;
    username = widget.user.username;
    super.initState();
    futurePosts = _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: FutureBuilder<List<Post>>(
        builder: (context, contentSnap) {
          if (contentSnap.hasData) {
            List<Post> userPosts = contentSnap.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  iconTheme: IconThemeData(
                    color: Palette.iconTheme,
                  ),
                  shadowColor: Colors.transparent,
                  brightness: Brightness.light,
                  backgroundColor: Palette.cardTheme,
                  title: Text(
                    'profile of @$username',
                    key: const Key('profileScreenText'),
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
                    edit
                        ? Container(
                            margin: const EdgeInsets.all(6.0),
                            child: IconButton(
                              key: const Key('editProfileButton'),
                              icon: Icon(Icons.edit),
                              iconSize: 25.0,
                              color: mainTheme,
                              onPressed: () =>
                                  _navigateAndDisplaySelection(context),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SliverToBoxAdapter(
                  child: ProfileCard(
                    user: loggedUser,
                    isMiniature: false,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
                          !_isTimeline
                              ? IconButton(
                                  icon: Icon(Icons.dehaze),
                                  iconSize: 25.0,
                                  color: mainTheme,
                                  onPressed: () {
                                    setState(() {
                                      _isTimeline = true;
                                    });
                                  },
                                )
                              : IconButton(
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
                userPosts.isEmpty
                    ? SliverToBoxAdapter(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Center(
                                child: Text(
                              "User doesn't have posts yet.",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                                letterSpacing: -0.8,
                              ),
                            )),
                          ),
                        ),
                      )
                    : _showPosts(loggedUser, _isTimeline, userPosts),
              ],
            );
          } else if (contentSnap.hasError) {
            return Text("${contentSnap.error}");
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: Palette.iconTheme,
                ),
                shadowColor: Colors.transparent,
                brightness: Brightness.light,
                backgroundColor: Palette.cardTheme,
                title: Text(
                  'profile of @$username',
                  key: const Key('profileScreenText'),
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
                  edit
                      ? Container(
                          margin: const EdgeInsets.all(6.0),
                          child: IconButton(
                            key: const Key('editProfileButton'),
                            icon: Icon(Icons.edit),
                            iconSize: 25.0,
                            color: mainTheme,
                            onPressed: () =>
                                _navigateAndDisplaySelection(context),
                          ),
                        )
                      : Container(),
                ],
              ),
              SliverToBoxAdapter(
                child: ProfileCard(
                  user: loggedUser,
                  isMiniature: false,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
                        !_isTimeline
                            ? IconButton(
                                icon: Icon(Icons.dehaze),
                                iconSize: 25.0,
                                color: mainTheme,
                                onPressed: () {
                                  setState(() {
                                    _isTimeline = true;
                                  });
                                },
                              )
                            : IconButton(
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
            ],
          );
        },
        future: futurePosts,
      ),
    );
  }
}
