// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/screens/home_screens/home_screen_after.dart';
import 'package:flutter_application_1/screens/home_screens/home_screen_before.dart';
import 'package:flutter_application_1/screens/email_auth/signup_screen.dart';
import 'package:flutter_application_1/services/notification_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      log("Please fill all the fields!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        await NotificationService().getToken();
        if (userCredential.user != null) {
          // final ref = FirebaseDatabase.instance.ref();
          // final snapshot = await ref
          //     .child("users/${userCredential.user?.uid.toString()}")
          //     .child("Checked In")
          //     .get();

          final ref = FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .withConverter(
                  fromFirestore: UserModel.fromFirestore,
                  toFirestore: (UserModel userModel, _) =>
                      userModel.toFirestore());

          final docSnap = await ref.get();
          final user = docSnap.data();

          if (user?.checkedIn == true) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const HomeScreenAfter()));
          } else {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const HomeScreenBefore()));
          }
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Login"),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration:
                            const InputDecoration(labelText: "Email Address"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          login();
                        },
                        color: Colors.blue,
                        child: const Text("Log In"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text("Create an Account"),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
