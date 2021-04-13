import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/config/palette.dart';

import 'widgets.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: CachedNetworkImage(
            imageUrl: post.imageUrl,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: Palette.cardGradient,
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            post.title,
            style: const TextStyle(
              fontSize: 18.0,
              color: Palette.postTheme,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Positioned(
          bottom: 4.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            post.user.name,
            style: const TextStyle(
              fontSize: 12.0,
              color: Palette.postTheme,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 44.0),
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Text(
                post.likes.toString(),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Palette.postTheme,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 60.0),
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Icon(
                Icons.thumb_up_outlined,
                size: 20.0,
                color: Palette.postTheme,
              ),
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 20.0),
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Icon(
                Icons.remove_red_eye_outlined,
                size: 20.0,
                color: Palette.postTheme,
              ),
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 4.0),
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Text(
                post.views.toString(),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Palette.postTheme,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
