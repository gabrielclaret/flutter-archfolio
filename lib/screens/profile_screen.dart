import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isTimeline = false;
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
              'profile',
              style: const TextStyle(
                color: Palette.iconTheme,
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
                  color: Palette.iconTheme,
                  onPressed: () => print(
                    "Edit Profile",
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Card(
              color: Palette.cardTheme,
              margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            radius: 63.0,
                            backgroundColor: Palette.profileTheme,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: CachedNetworkImageProvider(
                                  currentUser.imageUrl),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.name,
                              style: const TextStyle(
                                color: Palette.iconTheme,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.8,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Container(
                                width: 230, //make this responsive
                                child: Text(
                                  currentUser.description,
                                  style: const TextStyle(
                                    color: Palette.iconTheme,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 20,
                                  color: Palette.profileTheme,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    currentUser.location,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.8,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.calendar_today_rounded,
                                  size: 20,
                                  color: Palette.profileTheme,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    'Joined ${currentUser.joinDate}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.8,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
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
                            color: Palette.iconTheme,
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
                      color: Palette.iconTheme,
                      onPressed: () {
                        setState(() {
                          _isTimeline = true;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.grid_view),
                      iconSize: 25.0,
                      color: Palette.iconTheme,
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
                final Post post = currentUser.posts[index];
                return PostContainer(post: post);
              },
              childCount: currentUser.posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
