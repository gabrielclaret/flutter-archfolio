import 'package:flutter/material.dart';

import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/widgets/custom_app_bar.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

import 'screens.dart';

class NavScreen extends StatefulWidget {
  final User user;
  const NavScreen({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [HomeScreen(), SearchScreen()];
  final List<IconData> _icons = const [
    Icons.home_outlined,
    Icons.search,
    Icons.add,
    Icons.notifications_none,
    Icons.person_outline,
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    _screens.add(CreatePostScreen(user: widget.user));
    _screens.add(NotificationsScreen());
    _screens.add(ProfileScreen(user: widget.user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: CustomAppBar(
                  currentUser: widget.user,
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                ))
            : null,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
                color: Palette.cardTheme,
                child: CustomTabBar(
                  key: const Key('navScreenCustomBar'),
                  icons: _icons,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(() => _selectedIndex = index),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
