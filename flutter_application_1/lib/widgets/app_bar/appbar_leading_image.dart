import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';

// ignore: must_be_immutable
class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        settingsTab(context);
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath,
          height: 27.v,
          width: 32.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Help',
      style: optionStyle,
    ),
    Text(
      'Index 1: Line Settings',
      style: optionStyle,
    ),
    Text(
      'Index 2: Change Destination',
      style: optionStyle,
    ),
  ];

/*
  void _onItemTapped(int index) {
    _selectedIndex = index;
  }*/

  Widget settingsTab(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Text('Settings')),
            ListTile(
              title: const Text('Help'),
              selected: _selectedIndex == 0,
              onTap: () {
                //show stuff
                //close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Line Settings'),
              selected: _selectedIndex == 1,
              onTap: () {
                //show stuff
                //close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Change Destination'),
              selected: _selectedIndex == 2,
              onTap: () {
                //show stuff
                //close drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
