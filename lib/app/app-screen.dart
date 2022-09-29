import 'package:flutter/material.dart';
import 'package:know_me_frontend_v2/decks/decks-screen.dart';
import 'package:know_me_frontend_v2/home/home-screen.dart';
import 'package:know_me_frontend_v2/settings/settings-screen.dart';
import 'package:know_me_frontend_v2/services/storage-service.dart';
import 'package:navigation_drawer_menu/navigation_drawer.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu.dart';
import 'package:navigation_drawer_menu/navigation_drawer_menu_frame.dart';
import 'package:navigation_drawer_menu/navigation_drawer_state.dart';

import '../main.dart';

const alarmValueKey = ValueKey('Home');
const todoValueKey = ValueKey('Decks');
const photoValueKey = ValueKey('Settings');
const logOutValueKey = ValueKey('LogOut');

final Map<Key, MenuItemContent> menuItems = {
  alarmValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition("Home", alarmValueKey, iconData: Icons.dashboard)),
  todoValueKey: MenuItemContent(
      menuItem:
          MenuItemDefinition("Decks", todoValueKey, iconData: Icons.style)),
  photoValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Settings", photoValueKey,
          iconData: Icons.settings)),
  logOutValueKey: MenuItemContent(
      menuItem: MenuItemDefinition("Log out", logOutValueKey,
          iconData: Icons.logout)),
};

const menuColor = Color(0xFF6C6C6C);

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final NavigationDrawerState state = NavigationDrawerState();

  @override
  void initState() {
    super.initState();
    state.selectedMenuKey = menuItems.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Know Us Better"),
          leading: Builder(
            builder: (iconButtonBuilderContext) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                state.toggle(iconButtonBuilderContext);
                setState(() {});
              },
              tooltip: 'Toggle the menu',
            ),
          )),
      drawer: NavigationDrawer(
        menuBuilder: Builder(builder: getMenu),
        menuMode: state.menuMode(context),
      ),
      body: NavigationDrawerMenuFrame(
        body: Builder(
          builder: (c) => Column(
            children: [
              if (state.selectedMenuKey == menuItems.keys.toList()[0]) ...[
                const HomeScreen(),
              ] else if (state.selectedMenuKey ==
                  menuItems.keys.toList()[1]) ...[
                const DecksScreen(),
              ] else if (state.selectedMenuKey ==
                  menuItems.keys.toList()[2]) ...[
                const SettingsScreen(),
              ],
            ],
          ),
        ),
        menuBackgroundColor: menuColor,
        menuBuilder: Builder(builder: getMenu),
        menuMode: state.menuMode(context),
      ),
    );
  }

  Widget getMenu(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavigationDrawerMenu(
            highlightColor: Theme.of(context).indicatorColor,
            onSelectionChanged: (c, key) {
              state.selectedMenuKey = key;
              state.closeDrawer(c);
              setState(() {
                /// Logout button pressed
                if (state.selectedMenuKey == menuItems.keys.toList()[3]) {
                  StorageService.logOut();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MainApp();
                      },
                    ),
                    (r) {
                      return false;
                    },
                  );
                }
              });
            },
            menuItems: menuItems.values.toList(),
            selectedMenuKey: state.selectedMenuKey,
            itemPadding: const EdgeInsets.only(left: 5, right: 5),
            buildMenuButtonContent:
                (menuItemDefinition, isSelected, buildContentContext) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(menuItemDefinition.iconData,
                    color: isSelected
                        ? Theme.of(buildContentContext).backgroundColor
                        : Theme.of(buildContentContext)
                            .textTheme
                            .bodyText2!
                            .color),
                if (state.menuMode(context) != MenuMode.Thin)
                  const SizedBox(
                    width: 10,
                  ),
                if (state.menuMode(context) != MenuMode.Thin)
                  Text(menuItemDefinition.text,
                      style: isSelected
                          ? Theme.of(context).textTheme.bodyText2!.copyWith(
                              color:
                                  Theme.of(buildContentContext).backgroundColor)
                          : Theme.of(buildContentContext).textTheme.bodyText2)
              ],
            ),
          )
        ],
      );
}
