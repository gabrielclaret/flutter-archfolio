import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'dart:math';

class ProfileCard extends StatelessWidget {
  final User user;
  final bool isMiniature;

  const ProfileCard({
    Key key,
    @required this.user,
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
                          CachedNetworkImageProvider(user.imageUrl),
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
                      user.name,
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
                          user.description,
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
                                Icons.location_pin,
                                size: 20,
                                color: Palette.profileTheme,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  user.location,
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
                                  'Joined ${user.joined_at.substring(0, 10)}',
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
