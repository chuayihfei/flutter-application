import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key ?  key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  File? profilePic;

  void logOut() async 
  {
    await FirebaseAuth.instance.signOut();
    // Navigator.popUntil(context, (route) => route.isFirst);
    //Navigator.pushReplacement(context, CupertinoPageRoute(
    //  builder: (context) => SignInWithEmail()
    //));
  }

  void saveUser() async
  {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    int age = int.parse(ageController.text.trim());

    nameController.clear();
    emailController.clear();
    ageController.clear();

    if (name != "" && email != "" && profilePic != null)
    {
      UploadTask uploadTask = FirebaseStorage.instance.ref().child("profilePictures").child(const Uuid().v1()).putFile(profilePic!);

      StreamSubscription taskSubscription = uploadTask.snapshotEvents.listen((snapshot) {
        double percentage = snapshot.bytesTransferred/snapshot.totalBytes * 100;
        log(percentage.toString());
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      taskSubscription.cancel();

      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
        "age": age,
        "profilePic": downloadUrl,
        "sampleArray": [name, email, age]
      };
      FirebaseFirestore.instance.collection("users").add(userData);
      log("User created");
    }
    else
    {
      log("Please fill all the fields!");
    }

    setState(() {
      profilePic = null;
    });
  }

  void getInitialMessage() async 
  {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null)
    {
      if (message.data["page"] == "email")
      {
        // Navigator.push(context, CupertinoPageRoute(
        //   builder: (context) => SignUpScreen();
        // ));
      }
      else if (message.data["page"] == "phone")
      {
        // Navigator.push(context, CupertinoPageRoute(
        //   builder: (context) => SignInWithPhone();
        // ));
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Invalid Page!"),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          ));
      }
    }
  }
}