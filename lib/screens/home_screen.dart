import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/screens/bookmark_screen.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      desktop: _HomeScreenDesktop(),
      mobile: _HomeScreenMobile(),
    ));
  }
}

class _HomeScreenMobile extends StatefulWidget {
  const _HomeScreenMobile({Key key}) : super(key: key);

  @override
  __HomeScreenMobileState createState() => __HomeScreenMobileState();
}

class __HomeScreenMobileState extends State<_HomeScreenMobile> {
  static const Color mainTheme = Palette.mainColorTheme;
  bool _isTimeline = false;
  Future<User> futureUser;
  Future<List<dynamic>> contents;
  Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    List<Post> posts = [];
    Completer<List<Post>> completer = Completer();
    final response =
        await http.get(Uri.http(Settings.apiUrl, 'archfolio/v1/posts'));
    if (response.statusCode == 200) {
      var myPosts = jsonDecode(response.body);
      for (var post in myPosts) {
        Post myPost = Post.fromJson(post);
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

  Future<List<dynamic>> _fetchContents(int postId) async {
    final response = await http
        .get(Uri.http(Settings.apiUrl, 'archfolio/v1/posts/$postId/metadatas'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<User> _fetchUser(String userId) async {
    Completer<User> completer = Completer();
    final response = await http
        .get(Uri.http(Settings.apiUrl, 'archfolio/v1/users', {'id': userId}));

    if (response.statusCode == 200) {
      completer.complete(User.fromJson(jsonDecode(response.body)));
      return completer.future;
    } else {
      print('Failed to load user');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: FutureBuilder<List<Post>>(
        builder: (context, contentSnap) {
          if (contentSnap.hasData) {
            List<Post> posts = contentSnap.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  brightness: Brightness.light,
                  backgroundColor: Palette.cardTheme,
                  title: Text(
                    'archfolio',
                    key: const Key('homeScreenText'),
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
                        key: const Key('bookmarkButton'),
                        icon: Icon(Icons.bookmark_outline_sharp),
                        iconSize: 25.0,
                        color: mainTheme,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookmarkScreen(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SliverPadding(
                //   padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                //   sliver: SliverToBoxAdapter(
                //     child: ExploreCards(
                //       title: 'explore',
                //       exploreCards: exploreCards,
                //     ),
                //   ),
                // ),
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
                                'posts',
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
                _isTimeline
                    ? SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500,
                          mainAxisSpacing: 3.0,
                          crossAxisSpacing: 3.0,
                          childAspectRatio: 1.1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final Post post = posts[index];
                            return PostContainer(post: post, showStats: false);
                          },
                          childCount: posts.length,
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 4,
                        mainAxisSpacing: 3.0,
                        crossAxisSpacing: 3.0,
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Post post = posts[index];
                          return PostContainer(post: post, showStats: false);
                        },
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(2, index.isEven ? 3 : 2),
                      ),
              ],
            );
          } else if (contentSnap.hasError) {
            return Text("${contentSnap.error}");
          }
          return CircularProgressIndicator();
        },
        future: futurePosts,
      ),
    );
  }
}

class _HomeScreenDesktop extends StatefulWidget {
  const _HomeScreenDesktop({Key key}) : super(key: key);

  @override
  __HomeScreenDesktopState createState() => __HomeScreenDesktopState();
}

class __HomeScreenDesktopState extends State<_HomeScreenDesktop> {
  static const Color mainTheme = Palette.mainColorTheme;
  bool _isTimeline = false;
  Future<User> futureUser;
  Future<List<dynamic>> contents;
  Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    List<Post> posts = [];
    Completer<List<Post>> completer = Completer();
    final response =
        await http.get(Uri.http(Settings.apiUrl, 'archfolio/v1/posts'));
    if (response.statusCode == 200) {
      var myPosts = jsonDecode(response.body);
      for (var post in myPosts) {
        post['pfp_url'] =
            "https://images.unsplash.com/photo-1566869296469-609a90122355?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80";
        Post myPost = Post.fromJson(post);
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

  // Future<List<dynamic>> _fetchContents(int postId) async {
  //   final response = await http
  //       .get(Uri.http(Settings.apiUrl, 'archfolio/v1/posts/$postId/metadatas'));

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load post');
  //   }
  // }

  // Future<User> _fetchUser(String userId) async {
  //   Completer<User> completer = Completer();
  //   final response = await http
  //       .get(Uri.http(Settings.apiUrl, 'archfolio/v1/users', {'id': userId}));

  //   if (response.statusCode == 200) {
  //     completer.complete(User.fromJson(jsonDecode(response.body)));
  //     return completer.future;
  //   } else {
  //     print('Failed to load user');
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: FutureBuilder<List<Post>>(
        builder: (context, contentSnap) {
          if (contentSnap.hasData) {
            List<Post> posts = contentSnap.data;
            return Center(
              child: Card(
                child: Container(
                  width: size.width * 0.65,
                  height: double.infinity,
                  child: CustomScrollView(
                    slivers: [
                      // SliverAppBar(
                      //   brightness: Brightness.light,
                      //   backgroundColor: Palette.cardTheme,
                      //   title: Text(
                      //     'archfolio',
                      //     key: const Key('homeScreenText'),
                      //     style: const TextStyle(
                      //       color: mainTheme,
                      //       fontSize: 20.0,
                      //       fontWeight: FontWeight.bold,
                      //       letterSpacing: -0.9,
                      //     ),
                      //   ),
                      //   centerTitle: false,
                      //   floating: true,
                      //   actions: [
                      //     Container(
                      //       margin: const EdgeInsets.all(6.0),
                      //       child: IconButton(
                      //         key: const Key('bookmarkButton'),
                      //         icon: Icon(Icons.bookmark_outline_sharp),
                      //         iconSize: 25.0,
                      //         color: mainTheme,
                      //         onPressed: () => Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => BookmarkScreen(),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SliverPadding(
                      //   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                      //   sliver: SliverToBoxAdapter(
                      //     child: Card(
                      //       color: Palette.cardTheme,
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             child: Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 10.0),
                      //               child: Text(
                      //                 'posts',
                      //                 style: const TextStyle(
                      //                   color: mainTheme,
                      //                   fontSize: 18.0,
                      //                   fontWeight: FontWeight.bold,
                      //                   letterSpacing: -0.8,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           !_isTimeline
                      //               ? IconButton(
                      //                   icon: Icon(Icons.dehaze),
                      //                   iconSize: 25.0,
                      //                   color: mainTheme,
                      //                   onPressed: () {
                      //                     setState(() {
                      //                       _isTimeline = true;
                      //                     });
                      //                   },
                      //                 )
                      //               : IconButton(
                      //                   icon: Icon(Icons.grid_view),
                      //                   iconSize: 25.0,
                      //                   color: mainTheme,
                      //                   onPressed: () {
                      //                     setState(() {
                      //                       _isTimeline = false;
                      //                     });
                      //                   },
                      //                 ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SliverPadding(
                        padding: EdgeInsets.all(5),
                        sliver: SliverStaggeredGrid.countBuilder(
                          crossAxisCount: 8,
                          mainAxisSpacing: 3.0,
                          crossAxisSpacing: 3.0,
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Post post = posts[index];
                            return PostContainer(post: post, showStats: false);
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(2, index.isEven ? 3 : 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (contentSnap.hasError) {
            return Text("${contentSnap.error}");
          }
          return CircularProgressIndicator();
        },
        future: futurePosts,
      ),
    );
  }
}
