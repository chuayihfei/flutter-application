import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/register_screen/models/register_model.dart';

/// A provider class for the RegisterScreen.
///
/// This provider manages the state of the RegisterScreen, including the
/// current registerModelObj
class RegisterProvider extends ChangeNotifier {
  static TextEditingController nameFieldController = TextEditingController();

  static TextEditingController emailFieldController = TextEditingController();

  static TextEditingController passwordFieldController =
      TextEditingController();

  static TextEditingController confirmPasswordFieldController =
      TextEditingController();

  RegisterModel registerModelObj = RegisterModel();

  @override
  void dispose() {
    super.dispose();
    nameFieldController.dispose();
    emailFieldController.dispose();
    passwordFieldController.dispose();
    confirmPasswordFieldController.dispose();
  }
}
