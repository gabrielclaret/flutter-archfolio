import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'package:flutter_archfolio/model/models.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color mainTheme = Palette.mainColorTheme;
  bool _isTimeline = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Palette.cardTheme,
            title: Text(
              'archfolio',
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
                  icon: Icon(Icons.bookmark_outline_sharp),
                  iconSize: 30.0,
                  color: mainTheme,
                  onPressed: () => print(
                    "Bookmarks",
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            sliver: SliverToBoxAdapter(
              child: ExploreCards(
                title: 'Explore',
                exploreCards: exploreCards,
              ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: _isTimeline ? 500 : 300,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: _isTimeline ? 1.1 : 0.95,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final Post post = posts[index];
                return PostContainer(post: post);
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
