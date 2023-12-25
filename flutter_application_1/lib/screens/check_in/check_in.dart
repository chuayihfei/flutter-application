// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screens/home_screen_after.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => CheckInScreenState();
}

class CheckInScreenState extends State<CheckInScreen> {
  // ignore: unused_field
  UnityWidgetController? _unityWidgetController;

  void onUnityCreated(controller) async {
    _unityWidgetController = controller;

    const permission = Permission.camera;

    if (await permission.isDenied) {
      await permission.request();
    }
  }

  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    if (sceneInfo != null) {
      log('Received scene loaded from unity: ${sceneInfo.name}');
      log('Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
    }
  }

  void onUnityMessage(message) async {
    _unityWidgetController?.postMessage('AR Session Origin', 'ResetScene', '');
    log("Received message from Unity: ${message.toString()}");
    //User? user = FirebaseAuth.instance.currentUser;
    // DatabaseReference ref =
    //     FirebaseDatabase.instance.ref("users/${user?.uid.toString()}");
    // await ref.update({
    //   "Location": message.toString(),
    //   "Checked In": true,
    // });
    FirebaseFirestoreService.checkIn(message.toString());

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => const HomeScreenAfter()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Check In"),
        ),
        body: SafeArea(
            bottom: false,
            child: WillPopScope(
              onWillPop: () async {
                // Pop the category page if Android back button is pressed.
                return true;
              },
              child: Container(
                color: Colors.yellow,
                child: UnityWidget(
                  onUnityCreated: onUnityCreated,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  onUnityMessage: onUnityMessage,
                  fullscreen: false,
                ),
              ),
            )));
  }
}
