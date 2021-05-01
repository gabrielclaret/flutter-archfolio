import 'package:flutter/material.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/models.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static const Color mainTheme = Palette.mainColorTheme;
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
              'notifications',
              style: const TextStyle(
                color: mainTheme,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.9,
              ),
            ),
            centerTitle: false,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final UserNotification userNotification = notifications[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        userNotification.isViewed = true; //also goes to post
                      }),
                      child: SizedBox(
                        height: 70.0,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              _NotificationText(userNotification),
                              style: TextStyle(
                                color: Palette.iconTheme,
                                fontSize: 18.0,
                                fontWeight: userNotification.isViewed
                                    ? FontWeight.w200
                                    : FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 0.5,
                      thickness: 0.5,
                    )
                  ],
                );
              },
              childCount: notifications.length,
            ),
          ),
        ],
      ),
    );
  }
}

String _NotificationText(UserNotification userNotification) {
  switch (userNotification.interaction) {
    case 'like':
      return '${userNotification.user.name} liked your post ${userNotification.post.title}';
    case 'comment':
      return '${userNotification.user.name} commented on your post ${userNotification.post.title}';
    case 'follow':
      return '${userNotification.user.name} followed you';
  }
  return '';
}
