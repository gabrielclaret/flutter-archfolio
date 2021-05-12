import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/screens/screens.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const Color mainTheme = Palette.mainColorTheme;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Palette.cardTheme,
            title: Text(
              'explore',
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
              IconButton(
                iconSize: 25,
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                color: mainTheme,
              )
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            sliver: SliverToBoxAdapter(
              child: ExploreCards(
                title: 'just for you',
                exploreCards: exploreCards,
              ),
            ),
          ),
          SliverStaggeredGrid.countBuilder(
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
      ),
    );
  }
}

class PostSearch extends SearchDelegate<Post> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentPosts
        : posts
            .where((p) => p.title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.photo_sharp,
          ),
          title: Text(suggestionList[index].title),
        );
      },
    );
  }
}

class UserSearch extends SearchDelegate<User> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentUsers
        : users
            .where((u) => u.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.photo_sharp,
          ),
          title: Text(suggestionList[index].name),
        );
      },
    );
  }
}
