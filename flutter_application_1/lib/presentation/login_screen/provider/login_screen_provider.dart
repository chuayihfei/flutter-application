import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/login_screen/models/login_screen_model.dart';

/// A provider class for the LoginWithEmailIdScreen.
///
/// This provider manages the state of the LoginWithEmailIdScreen, including the
/// current loginWithEmailIdModelObj
class LoginWithEmailIdProvider extends ChangeNotifier {
  static TextEditingController emailController = TextEditingController();

  static TextEditingController passwordController = TextEditingController();

  LoginWithEmailIdModel loginWithEmailIdModelObj = LoginWithEmailIdModel();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
