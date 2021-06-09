import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final bool isMiniature;

  const PostCard({
    Key key,
    @required this.post,
    this.isMiniature = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(3),
      color: Palette.cardTheme,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    radius: isMiniature ? 30 : 63.0,
                    backgroundColor: Palette.profileTheme,
                    child: CircleAvatar(
                      radius: isMiniature ? 29 : 60.0,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          CachedNetworkImageProvider('https://images.unsplash.com/photo-1511818966892-d7d671e672a2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                        color: Palette.profileTheme,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Container(
                        width: isMiniature ? 300 : 230, //make this responsive
                        child: Text(
                          post.description,
                          style: TextStyle(
                            color: Palette.iconTheme,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),
                    ),
                    isMiniature
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 25),
                    isMiniature
                        ? const SizedBox.shrink()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.thumb_up_alt,
                                size: 20,
                                color: Palette.profileTheme,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 2.0),
                              //   child: Text(
                              //     post.likes.toString(),
                              //     style: const TextStyle(
                              //       color: Colors.grey,
                              //       fontSize: 15.0,
                              //       fontWeight: FontWeight.normal,
                              //       letterSpacing: -0.8,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.remove_red_eye_sharp,
                                size: 20,
                                color: Palette.profileTheme,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  post.views.toString(),
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
    );
  }
}
