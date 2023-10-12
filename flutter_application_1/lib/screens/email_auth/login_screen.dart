import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget
{
  const LoginScreen({ Key? key }) : super(key:key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> 
{
  TextEditingController m_emailController = TextEditingController();
  TextEditingController m_passwordController = TextEditingController();

  void login()
  {
    String email = m_emailController.text.trim();
    String password = m_passwordController.text.trim();

    if (email == "" || password == "")
    {
      log("Please fill all the fields!");
    }
    else
    {
      try 
      {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null)
        {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, CupertinoPageRoute(
            builder: (context) => HomeScreen()
          ));
        }
      }
    }
  }
}