import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final isBottomIndicator;

  const CustomTabBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
    this.isBottomIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? Border(
                bottom: BorderSide(
                  color: Palette.iconTheme,
                  width: 3.0,
                ),
              )
            : Border(
                top: BorderSide(
                  color: Palette.iconTheme,
                  width: 3.0,
                ),
              ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == selectedIndex
                        ? Palette.iconTheme
                        : Palette.notSelectedTheme,
                    size: i == 2 ? 35.0 : 30.0, //create icon
                  ),
                ),
              ))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
