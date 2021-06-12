import 'package:flutter/material.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.scaffold,
        body: Responsive(
          mobile: _NotificationsScreenMobile(),
          desktop: _NotificationsScreenDesktop(),
        ));
  }
}

class _NotificationsScreenMobile extends StatefulWidget {
  const _NotificationsScreenMobile({Key key}) : super(key: key);

  @override
  __NotificationsScreenMobileState createState() =>
      __NotificationsScreenMobileState();
}

class __NotificationsScreenMobileState
    extends State<_NotificationsScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Palette.cardTheme,
          title: Text(
            'notifications',
            key: const Key('notificationsScreenText'),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
    );
  }
}

class _NotificationsScreenDesktop extends StatefulWidget {
  const _NotificationsScreenDesktop({Key key}) : super(key: key);

  @override
  __NotificationsScreenDesktopState createState() =>
      __NotificationsScreenDesktopState();
}

class __NotificationsScreenDesktopState
    extends State<_NotificationsScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: Palette.scaffold),
          //color: Palette.scaffold,
          width: size.width * 0.55,
          height: double.infinity,
          child: CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   brightness: Brightness.light,
              //   backgroundColor: Palette.cardTheme,
              //   title: Text(
              //     'notifications',
              //     key: const Key('notificationsScreenText'),
              //     style: const TextStyle(
              //       color: Palette.mainColorTheme,
              //       fontSize: 20.0,
              //       fontWeight: FontWeight.bold,
              //       letterSpacing: -0.9,
              //     ),
              //   ),
              //   centerTitle: false,
              //   floating: true,
              // ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final UserNotification userNotification =
                        notifications[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () => setState(() {
                            userNotification.isViewed =
                                true; //also goes to post
                          }),
                          child: SizedBox(
                            height: 70.0,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
        ),
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
