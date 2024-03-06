import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class SettingsDrawer extends StatelessWidget {
  //final UnityWidgetController? controller;
  final Function(String) sendMessageToUnity;
  //@required this.controller
  SettingsDrawer({required this.sendMessageToUnity, Key? key})
      : super(key: key);

  //static const platform =
  // MethodChannel('com.example.flutter_unity_integration/flutter');

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
      'Index 3: Show Minimap',
      style: optionStyle,
    ),
    Text(
      'Index 4: Reset Environment',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
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
                sendMessageToUnity('Help UI');
                //close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Line Settings'),
              selected: _selectedIndex == 2,
              onTap: () {
                //show stuff
                log('line settings pressed');
                //platform.invokeMethod('openUnityWidget');
                //controller?.postMessage('LineSettingsPanel', 'Toggle',
                // 'Toggle Line Settings Panel');
                sendMessageToUnity('Toggle Line Settings Panel');
                //close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Show Minimap'),
              selected: _selectedIndex == 3,
              onTap: () {
                //show stuff
                sendMessageToUnity('Show Minimap');
                //close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Reset Environment'),
              selected: _selectedIndex == 4,
              onTap: () {
                //show stuff
                sendMessageToUnity('Reset Environment');
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
