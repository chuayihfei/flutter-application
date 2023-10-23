// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/email_auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const LoginScreen()));
  }

  void checkIn() async {
    log("Check In Button Pressed!");
    // Navigator.popUntil(context, (route) => route.isFirst);
    // Navigator.pushReplacement(
    //     context, CupertinoPageRoute(builder: (context) => const LoginScreen()));
  }

  void groupChat() async {
    log("Group Chat Button Pressed!");
    // Navigator.popUntil(context, (route) => route.isFirst);
    // Navigator.pushReplacement(
    //     context, CupertinoPageRoute(builder: (context) => const LoginScreen()));
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
                ]))
          ],
        )));
  }
}