// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/check_in/check_in.dart';
import 'package:flutter_application_1/screens/email_auth/login_screen.dart';
import 'package:flutter_application_1/screens/group_chat/chats_screen.dart';
import 'package:flutter_application_1/screens/way_finder/way_finder.dart';

class HomeScreenBefore extends StatefulWidget {
  const HomeScreenBefore({Key? key}) : super(key: key);

  @override
  State<HomeScreenBefore> createState() => HomeScreenBeforeState();
}

class HomeScreenBeforeState extends State<HomeScreenBefore> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => const LoginScreen()));
  }

  void checkIn() async {
    log("Check In Button Pressed!");
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => const CheckInScreen()));
  }

  void groupChat() async {
    log("Group Chat Button Pressed!");
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => const ChatsScreen()));
  }

  void wayFinder() async {
    log("Way Finder Button Pressed!");
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => const WayFinderScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Home"),
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(100),
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      groupChat();
                    },
                    child: Text("Group Chat"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkIn();
                    },
                    child: Text("Check In"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      wayFinder();
                    },
                    child: Text("Way Finder"),
                  ),
                ]))
          ],
        )));
  }
}
