import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  SettingsDrawer({
    Key? key,
  }) : super(key: key);

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Way Finder',
      style: optionStyle,
    ),
    Text(
      'Index 1: Help',
      style: optionStyle,
    ),
    Text(
      'Index 2: Line Settings',
      style: optionStyle,
    ),
    Text(
      'Index 3: Change Destination',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              child: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: const Text('Way Finder'),
            selected: _selectedIndex == 0,
            onTap: () {
              //show stuff
              //close drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Help'),
            selected: _selectedIndex == 1,
            onTap: () {
              //show stuff
              //close drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Line Settings'),
            selected: _selectedIndex == 2,
            onTap: () {
              //show stuff
              //close drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Change Destination'),
            selected: _selectedIndex == 3,
            onTap: () {
              //show stuff
              //close drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
