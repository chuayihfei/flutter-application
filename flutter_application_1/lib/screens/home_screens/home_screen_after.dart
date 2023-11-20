// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/check_in/check_in.dart';
import 'package:flutter_application_1/screens/email_auth/login_screen.dart';
import 'package:flutter_application_1/screens/group_chat/chats_screen.dart';
import 'package:flutter_application_1/screens/home_screens/home_screen_before.dart';

class HomeScreenAfter extends StatefulWidget {
  const HomeScreenAfter({Key? key}) : super(key: key);

  @override
  State<HomeScreenAfter> createState() => HomeScreenAfterState();
}

class HomeScreenAfterState extends State<HomeScreenAfter> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const LoginScreen()));
  }

  void checkOut() async {
    log("Check Out Button Pressed!");
    User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${user?.uid.toString()}");
    await ref.update({
      "Location": "",
      "Checked In": false,
    });
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const HomeScreenBefore()));
  }

  void groupChat() async {
    log("Group Chat Button Pressed!");
    Navigator.popUntil(context, (route) => route.isFirst);

    log("After Pop after pressed");
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const ChatsScreen()));

    log("After PushReplacement after pressed");
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
                      checkOut();
                    },
                    child: Text("Check Out"),
                  ),
                ]))
          ],
        )));
  }
}
