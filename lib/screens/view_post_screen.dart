import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/model/post_model.dart';
import 'package:flutter_archfolio/model/user_model.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_archfolio/config/palette.dart';

import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/model/content_model.dart';
import 'package:http/http.dart' as http;

class ViewPostScreen extends StatefulWidget {
  final Post post;

  const ViewPostScreen({
    Key key,
    @required this.post,
  }) : super(key: key);
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  Post post;
  Future<User> futureUser;
  Future<List<dynamic>> contents;
  ScrollController _scrollViewController;

  @override
  void initState() {
    final int postId = widget.post.id;
    post = widget.post;
    super.initState();
    contents = _fetchContents(postId);
    futureUser = _fetchUser(post.userId.toString());
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backgroundTheme,
        body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                backgroundColor: Palette.backgroundTheme,
                shadowColor: Colors.transparent,
                iconTheme: IconThemeData(
                  color: Palette.mainColorTheme,
                ),
                title: Text(
                  post.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.9,
                  ),
                ),
                centerTitle: true,
                floating: true,
                pinned: true,
                snap: true,
              ),
              SliverToBoxAdapter(
                child: FutureBuilder<User>(
                  builder: (context, contentSnap) {
                    if (contentSnap.hasData) {
                      User user = contentSnap.data;
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                child: Text(
                                  post.description,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: -0.8,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () => print(user.name),
                              child: Text(
                                user.username,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: -0.8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (contentSnap.hasError) {
                      return Text("${contentSnap.error}");
                    }
                    return CircularProgressIndicator();
                  },
                  future: futureUser,
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  builder: (context, contentSnap) {
                    if (contentSnap.hasData) {
                      return ListView.builder(
                        itemCount: contentSnap.data.length,
                        itemBuilder: (context, index) {
                          double contentHeight;
                          HashMap<String, dynamic> contentMap =
                              HashMap.from(contentSnap.data[index]);
                          Content content = Content.fromJson(contentMap);

                          if (content.isUrl) {
                            _calculateImageDimension(content.content).then(
                                (size) =>
                                    contentHeight = size.height.toDouble());
                          }
                          return Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              content.isUrl
                                  ? Container(
                                      width: double.infinity,
                                      height: contentHeight,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        child: CachedNetworkImage(
                                          imageUrl: content.content,
                                          height: contentHeight,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          content.content,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: -0.7,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        },
                      );
                    } else if (contentSnap.hasError) {
                      return Text("${contentSnap.error}");
                    }
                    return CircularProgressIndicator();
                  },
                  future: contents,
                ),
              ),
            ],
          ),
        ));
  }
}

Future<Size> _calculateImageDimension(String imageUrl) {
  Completer<Size> completer = Completer();
  var listener = (ImageInfo image, bool synchronousCall) {
    var myImage = image.image;
    Size size = Size(myImage.width, myImage.height);
    completer.complete(size);
  };
  Image image = Image.network(imageUrl);
  image.image
      .resolve(ImageConfiguration())
      .addListener(ImageStreamListener(listener));
  image.image
      .resolve(ImageConfiguration())
      .removeListener(ImageStreamListener(listener));
  return completer.future;
}
