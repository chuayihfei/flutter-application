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
import 'package:flutter_application_1/screens/login_screen/signup_screen.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:flutter_application_1/widgets/custom_image_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgImage1,
                      height: 243.v,
                      width: 386.h,
                    ),
                    SizedBox(height: 1.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "lbl_login".tr,
                        style: CustomTextStyles.headlineSmallMontserratPrimary,
                      ),
                    ),
                    SizedBox(height: 27.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "lbl_email_address".tr,
                        style: CustomTextStyles.titleMediumOnPrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Selector<LoginWithEmailIdProvider, TextEditingController?>(
                      selector: (
                        context,
                        provider,
                      ) =>
                          provider.emailController,
                      builder: (context, emailController, child) {
                        return CustomTextFormField(
                          controller: emailController,
                          hintText: "msg_enter_your_email".tr,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                (!isValidEmail(value, isRequired: true))) {
                              return "err_msg_please_enter_valid_email".tr;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 23.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "lbl_password".tr,
                        style: CustomTextStyles.titleMediumOnPrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 13.v),
                    Selector<LoginWithEmailIdProvider, TextEditingController?>(
                      selector: (
                        context,
                        provider,
                      ) =>
                          provider.passwordController,
                      builder: (context, passwordController, child) {
                        return CustomTextFormField(
                          controller: passwordController,
                          hintText: "msg_enter_your_password".tr,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null ||
                                (!isValidPassword(value, isRequired: true))) {
                              return "err_msg_please_enter_valid_password".tr;
                            }
                            return null;
                          },
                          obscureText: true,
                        );
                      },
                    ),
                    SizedBox(height: 24.v),
                    CustomElevatedButton(
                      text: "lbl_login".tr,
                    ),
                    SizedBox(height: 25.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "msg_don_t_you_have_an2".tr,
                            style: CustomTextStyles.bodyLargeff848fad,
                          ),
                          TextSpan(
                            text: "lbl_register".tr,
                            style: CustomTextStyles.titleMediumff5c1d78,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
