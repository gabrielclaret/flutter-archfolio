import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/screens/view_post_screen.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

import 'screens.dart';

// falta: atualizar a lista de user/post depois do search = 0, para ele mostrar recentUsers e nao users.

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: _SearchScreenDesktop(),
      mobile: _SearchScreenMobile(),
    );
  }
}

// deixar essa parte mais agnóstica

class _SearchScreenDesktop extends StatefulWidget {
  const _SearchScreenDesktop({Key key}) : super(key: key);

  @override
  __SearchScreenDesktopState createState() => __SearchScreenDesktopState();
}

class __SearchScreenDesktopState extends State<_SearchScreenDesktop> {
  TextEditingController searchController;

  List<User> usersForDisplay;
  List<Post> postsForDisplay;

  Future<List<User>> futureUsers;
  Future<List<Post>> futurePosts;

  Future<List<Post>> _fetchPosts(String name) async {
    List<Post> posts = [];
    Completer<List<Post>> completer = Completer();
    var response;
    var dio = Dio();
    bool error = false;

    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

    if (name == "") {
      response = await dio.get('/posts');
    } else {
      response = await dio.get('/posts?title=$name').catchError((e) {
        error = true;
      });
    }
    if (error) {
      response = await dio.get('/posts');
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
      for (var resp in response.data) {
        Post myPost = Post.fromJson(jsonDecode(jsonEncode(resp)));
        posts.add(myPost);
      }

      completer.complete(posts);
      setState(() {
        futurePosts = completer.future;
      });

      return completer.future;
    }
  }

  Future<List<User>> _fetchUsers(String name) async {
    List<User> users = [];
    Completer<List<User>> completer = Completer();
    bool error = false;
    var dio = Dio();
    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();
    var response;

    if (name == "") {
      response = await dio.get('/users');
      for (var resp in response.data) {
        User myUser = User.fromJson(jsonDecode(jsonEncode(resp)));
        users.add(myUser);
      }

      completer.complete(users);
      setState(() {
        futureUsers = completer.future;
      });

      return completer.future;
    } else {
      response = await dio.get('/users?identification=$name').catchError((e) {
        error = true;
      });
    }

    if (error) {
      response = await dio.get('/users');
      for (var resp in response.data) {
        User myUser = User.fromJson(jsonDecode(jsonEncode(resp)));
        users.add(myUser);
      }
      completer.complete(users);
      setState(() {
        futureUsers = completer.future;
      });
      error = false;
      return completer.future;
    } else {
      for (var resp in response.data) {
        User myUser = User.fromJson(jsonDecode(jsonEncode(resp)));
        users.add(myUser);
      }

      completer.complete(users);
      setState(() {
        futureUsers = completer.future;
      });

      return completer.future;
    }
  }

  static const Color mainTheme = Palette.mainColorTheme;

  @override
  void initState() {
    usersForDisplay = recentUsers;
    postsForDisplay = recentPosts;
    searchController = TextEditingController();
    super.initState();
    futurePosts = _fetchPosts("");
    futureUsers = _fetchUsers("");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        child: Container(
          width: size.width * 0.55,
          height: double.infinity,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                actions: [],
                iconTheme: IconThemeData(
                  color: mainTheme,
                ),
                backgroundColor: Palette.cardTheme,
                title: Container(
                  height: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextField(
                            controller: searchController,
                            key: const Key('searchField'),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(15, 20, 0,
                                  0), // top padding is half the container height
                              hintText: 'search',
                              // suffixIcon: Icon(
                              //   Icons.search,
                              //   color: mainTheme,
                              //   size: 25,
                              // ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainTheme)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainTheme)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainTheme)),
                            ),
                            onChanged: (text) async {
                              // text = text.toLowerCase();

                              // print('im here');
                              // print(text);
                              // // try to make this send to backend and return
                              // futurePosts = _fetchPosts(text);
                              // futureUsers = _fetchUsers(text);
                              // // setState(() {
                              // //   usersForDisplay = users.where((user) {
                              // //     var userName = user.name.toLowerCase();
                              // //     return userName.contains(text);
                              // //   }).toList();
                              // //   postsForDisplay = posts.where((post) {
                              // //     var postTitle = post.title.toLowerCase();
                              // //     return postTitle.contains(text);
                              // //   }).toList();
                              // //   // adicionar postTags, e concatenar os resultados na lista postForDisplay
                              // // });
                            },
                            cursorColor: mainTheme,
                            style: TextStyle(color: Palette.iconTheme),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(6.0),
                            child: IconButton(
                              key: const Key('editProfileButton'),
                              icon: Icon(Icons.search),
                              iconSize: 25.0,
                              color: mainTheme,
                              onPressed: () async {
                                String text = searchController.text;

                                futurePosts = _fetchPosts(text);
                                futureUsers = _fetchUsers(text);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  labelColor: mainTheme,
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: mainTheme,
                  tabs: [
                    Tab(text: 'user'),
                    Tab(text: 'posts'),
                  ],
                ),
              ),
              // body: TabBarView(
              //   children: [
              //     _SearchUsers(
              //       usersList: usersForDisplay,
              //     ),
              //     _SearchPosts(
              //       postList: postsForDisplay,
              //     )
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchScreenMobile extends StatefulWidget {
  const _SearchScreenMobile({Key key}) : super(key: key);

  @override
  __SearchScreenMobileState createState() => __SearchScreenMobileState();
}

class __SearchScreenMobileState extends State<_SearchScreenMobile> {
  TextEditingController searchController;

  List<User> usersForDisplay;
  List<Post> postsForDisplay;

  Future<List<User>> futureUsers;
  Future<List<Post>> futurePosts;

  Future<List<Post>> _fetchPosts(String name) async {
    List<Post> posts = [];
    Completer<List<Post>> completer = Completer();
    var response;
    var dio = Dio();
    bool error = false;

    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

    if (name == "") {
      response = await dio.get('/posts');
    } else {
      response = await dio.get('/posts?title=$name').catchError((e) {
        error = true;
      });
    }
    if (error) {
      response = await dio.get('/posts');
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
      for (var resp in response.data) {
        Post myPost = Post.fromJson(jsonDecode(jsonEncode(resp)));
        posts.add(myPost);
      }

      completer.complete(posts);
      setState(() {
        futurePosts = completer.future;
      });

      return completer.future;
    }
  }

  Future<List<User>> _fetchUsers(String name) async {
    List<User> users = [];
    Completer<List<User>> completer = Completer();
    bool error = false;
    var dio = Dio();
    dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();
    var response;

    if (name == "") {
      response = await dio.get('/users');
      for (var resp in response.data) {
        User myUser = User.fromJson(jsonDecode(jsonEncode(resp)));
        users.add(myUser);
      }

      completer.complete(users);
      setState(() {
        futureUsers = completer.future;
      });

      return completer.future;
    } else {
      response = await dio.get('/users?identification=$name').catchError((e) {
        error = true;
      });
    }

    if (error) {
      response = await dio.get('/users');
      for (var resp in response.data) {
        User myUser = User.fromJson(jsonDecode(jsonEncode(resp)));
        users.add(myUser);
      }
      completer.complete(users);
      setState(() {
        futureUsers = completer.future;
      });
      error = false;
      return completer.future;
    } else {
      for (var resp in response.data) {
        User myUser = User.fromJson(jsonDecode(jsonEncode(resp)));
        users.add(myUser);
      }

      completer.complete(users);
      setState(() {
        futureUsers = completer.future;
      });

      return completer.future;
    }
  }

  static const Color mainTheme = Palette.mainColorTheme;

  @override
  void initState() {
    usersForDisplay = recentUsers;
    postsForDisplay = recentPosts;
    searchController = TextEditingController();
    super.initState();
    futurePosts = _fetchPosts("");
    futureUsers = _fetchUsers("");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [],
          iconTheme: IconThemeData(
            color: mainTheme,
          ),
          backgroundColor: Palette.cardTheme,
          title: Container(
            height: 40,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: searchController,
                      key: const Key('searchField'),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 20, 0,
                            0), // top padding is half the container height
                        hintText: 'search',
                        // suffixIcon: Icon(
                        //   Icons.search,
                        //   color: mainTheme,
                        //   size: 25,
                        // ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainTheme)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainTheme)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: mainTheme)),
                      ),
                      onChanged: (text) async {
                        // text = text.toLowerCase();

                        // print('im here');
                        // print(text);
                        // // try to make this send to backend and return
                        // futurePosts = _fetchPosts(text);
                        // futureUsers = _fetchUsers(text);
                        // // setState(() {
                        // //   usersForDisplay = users.where((user) {
                        // //     var userName = user.name.toLowerCase();
                        // //     return userName.contains(text);
                        // //   }).toList();
                        // //   postsForDisplay = posts.where((post) {
                        // //     var postTitle = post.title.toLowerCase();
                        // //     return postTitle.contains(text);
                        // //   }).toList();
                        // //   // adicionar postTags, e concatenar os resultados na lista postForDisplay
                        // // });
                      },
                      cursorColor: mainTheme,
                      style: TextStyle(color: Palette.iconTheme),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(6.0),
                      child: IconButton(
                        key: const Key('editProfileButton'),
                        icon: Icon(Icons.search),
                        iconSize: 25.0,
                        color: mainTheme,
                        onPressed: () async {
                          String text = searchController.text;

                          futurePosts = _fetchPosts(text);
                          futureUsers = _fetchUsers(text);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottom: TabBar(
            labelColor: mainTheme,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: mainTheme,
            tabs: [
              Tab(text: 'user'),
              Tab(text: 'posts'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _SearchUsers(
              futureUsers: futureUsers,
            ),
            _SearchPosts(
              futurePosts: futurePosts,
            )
          ],
        ),
      ),
    );
  }
}

class _SearchUsers extends StatefulWidget {
  final Future<List<User>> futureUsers;

  const _SearchUsers({
    Key key,
    @required this.futureUsers,
  }) : super(key: key);

  @override
  __SearchUsersState createState() => __SearchUsersState();
}

class __SearchUsersState extends State<_SearchUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        builder: (context, contentSnap) {
          if (contentSnap.hasData) {
            List<User> users = contentSnap.data;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final User user = users[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        user: user,
                        isEdit: false,
                      ),
                    ),
                  ),
                  child: ProfileCard(
                    user: user,
                    isMiniature: true,
                  ),
                );
              },
            );
          } else if (contentSnap.hasError) {
            return Text("${contentSnap.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
        future: widget.futureUsers,
      ),
    );
  }
}

class _SearchPosts extends StatefulWidget {
  final Future<List<Post>> futurePosts;

  const _SearchPosts({Key key, this.futurePosts}) : super(key: key);

  @override
  __SearchPostsState createState() => __SearchPostsState();
}

class __SearchPostsState extends State<_SearchPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        builder: (context, contentSnap) {
          if (contentSnap.hasData) {
            List<Post> posts = contentSnap.data;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final Post post = posts[index];
                return GestureDetector(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPostScreen(post: post),
                          ),
                        ),
                    child: PostCard(
                      post: post,
                      isMiniature: true,
                    ));
              },
            );
          } else if (contentSnap.hasError) {
            return Text("${contentSnap.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
        future: widget.futurePosts,
      ),
    );
  }
}
