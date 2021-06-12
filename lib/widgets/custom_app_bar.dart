import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/user_model.dart';
import 'package:flutter_archfolio/widgets/custom_tab_bar.dart';
import 'package:flutter_archfolio/widgets/user_card.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    Key key,
    @required this.currentUser,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 55.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'archfolio',
              style: const TextStyle(
                color: Palette.mainColorTheme,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.1,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              icons: icons,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UserCard(user: currentUser),
                const SizedBox(width: 12.0),
                // IconButton(
                //   icon: Icon(Icons.search),
                //   iconSize: 30.0,
                //   onPressed: () => print('Search'),
                // ),
                // IconButton(
                //   icon: Icon(MdiIcons.facebookMessenger),
                //   iconSize: 30.0,
                //   onPressed: () => print('Messenger'),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
