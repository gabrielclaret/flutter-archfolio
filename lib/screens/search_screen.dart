import 'package:flutter/material.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/screens/view_post_screen.dart';
import 'screens.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'package:flutter_archfolio/model/models.dart';

// falta: atualizar a lista de user/post depois do search = 0, para ele mostrar recentUsers e nao users.

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<User> usersForDisplay;
  List<Post> postsForDisplay;

  static const Color mainTheme = Palette.mainColorTheme;

  @override
  void initState() {
    usersForDisplay = recentUsers;
    postsForDisplay = recentPosts;
    super.initState();
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
              child: TextField(
                key: const Key('searchField'),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                      15, 20, 0, 0), // top padding is half the container height
                  hintText: 'search',
                  suffixIcon: Icon(
                    Icons.search,
                    color: mainTheme,
                    size: 25,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainTheme)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainTheme)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainTheme)),
                ),
                onChanged: (text) {
                  text = text.toLowerCase();
                  // try to make this send to backend and return
                  setState(() {
                    usersForDisplay = users.where((user) {
                      var userName = user.name.toLowerCase();
                      return userName.contains(text);
                    }).toList();
                    postsForDisplay = posts.where((post) {
                      var postTitle = post.title.toLowerCase();
                      return postTitle.contains(text);
                    }).toList();
                    // adicionar postTags, e concatenar os resultados na lista postForDisplay
                  });
                },
                cursorColor: mainTheme,
                style: TextStyle(color: Palette.iconTheme),
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
              usersList: usersForDisplay,
            ),
            _SearchPosts(
              postList: postsForDisplay,
            )
          ],
        ),
      ),
    );
  }
}

// deixar essa parte mais agnóstica

class _SearchUsers extends StatefulWidget {
  final List<User> usersList;

  const _SearchUsers({Key key, this.usersList}) : super(key: key);

  @override
  __SearchUsersState createState() => __SearchUsersState();
}

class __SearchUsersState extends State<_SearchUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.usersList.length,
        itemBuilder: (BuildContext context, int index) {
          final User user = widget.usersList[index];
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
      ),
    );
  }
}

class _SearchPosts extends StatefulWidget {
  final List<Post> postList;

  const _SearchPosts({Key key, this.postList}) : super(key: key);

  @override
  __SearchPostsState createState() => __SearchPostsState();
}

class __SearchPostsState extends State<_SearchPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.postList.length,
        itemBuilder: (BuildContext context, int index) {
          final Post post = widget.postList[index];
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
      ),
    );
  }
}
