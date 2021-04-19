import 'package:flutter/material.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

import 'package:flutter_archfolio/config/palette.dart';

import 'screens.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    Scaffold(),
    NotificationsScreen(),
    ProfileScreen(),
  ];
  final List<IconData> _icons = const [
    Icons.home_outlined,
    Icons.search,
    Icons.add,
    Icons.notifications_none,
    Icons.person_outline,
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          color: Palette.cardTheme,
          child: CustomTabBar(
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
