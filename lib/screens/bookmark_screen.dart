import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _isTimeline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundTheme,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                  icon: Icon(Icons.arrow_back_outlined, color: Palette.mainColorTheme,),
                  tooltip: 'Click to Home Screen',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            brightness: Brightness.light,
            backgroundColor: Palette.cardTheme,
            title: Text(
              'bookmarks',
              style: const TextStyle(
                color: Palette.mainColorTheme,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.9,
              ),
            ),
            centerTitle: false,
            floating: true,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Posts',
                          style: const TextStyle(
                            color: Palette.mainColorTheme,
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
                            color: Palette.mainColorTheme,
                            onPressed: () {
                              setState(() {
                                _isTimeline = true;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.grid_view),
                            iconSize: 25.0,
                            color: Palette.mainColorTheme,
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
          SliverToBoxAdapter(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    "User doesn't have Bookmarks yet.",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      letterSpacing: -0.8,
                    ),
                  ),
                ), //pegar essa parte do profile_screen
              ),
            ),
          )
        ],
      ),
    );
  }
}
