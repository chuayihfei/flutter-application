import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!");
    } else if (password != cPassword) {
      log("Passwords do not match!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
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
          title: const Text("Create an Account"),
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
                      PasswordField(
                        controller: passwordController,
                        hintText: "Password",
                        errorMessage:
                            "Must contain\n-A Uppercase Letter\n-A Lowercase Letter\n-A digit\n-A special Character\n-A Minimum of 8 Characters",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: cPasswordController,
                        decoration: const InputDecoration(
                            labelText: "Confirm Password"),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          createAccount();
                        },
                        color: Colors.blue,
                        child: const Text("Create Account"),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
