// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:flutter_application_1/widgets/custom_elevated_button.dart';
import 'package:flutter_application_1/widgets/custom_text_form_field.dart';
import 'provider/register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key})
      : super(
          key: key,
        );

  @override
  RegisterScreenState createState() => RegisterScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: const RegisterScreen(),
    );
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void createAccount() async {
    String name = RegisterProvider.nameFieldController.text.trim();
    String email = RegisterProvider.emailFieldController.text.trim();
    String password = RegisterProvider.passwordFieldController.text.trim();
    String cPassword =
        RegisterProvider.confirmPasswordFieldController.text.trim();

    if (name == "" || email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!");
    } else if (password != cPassword) {
      log("Passwords do not match!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          userCredential.user!.updateDisplayName(name);
          await FirebaseFirestoreService.createUser(
            //image: image,
            email: email,
            uid: userCredential.user?.uid.toString(),
            name: name,
          );
          await NotificationService().requestPermission();

          log("User Created!");
          NavigatorService.goBack();
        }
      } on FirebaseAuthException catch (e) {
        final snackBar = SnackBar(content: Text(e.message!));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.h,
                  vertical: 10.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage1,
                      height: 122.v,
                      width: 277.h,
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 23.v),
                    Text(
                      "lbl_register".tr,
                      style: CustomTextStyles.headlineSmallMontserratPrimary,
                    ),
                    SizedBox(height: 27.v),
                    Text(
                      "lbl_your_name".tr,
                      style: CustomTextStyles.titleMediumOnPrimaryContainer,
                    ),
                    SizedBox(height: 13.v),
                    _buildNameField(context),
                    SizedBox(height: 23.v),
                    Text(
                      "lbl_email_address".tr,
                      style: CustomTextStyles.titleMediumOnPrimaryContainer,
                    ),
                    SizedBox(height: 13.v),
                    _buildEmailField(context),
                    SizedBox(height: 23.v),
                    Text(
                      "lbl_password".tr,
                      style: CustomTextStyles.titleMediumOnPrimaryContainer,
                    ),
                    SizedBox(height: 13.v),
                    _buildPasswordField(context),
                    SizedBox(height: 23.v),
                    Text(
                      "msg_confirm_password".tr,
                      style: CustomTextStyles.titleMediumOnPrimaryContainer,
                    ),
                    SizedBox(height: 13.v),
                    _buildConfirmPasswordField(context),
                    SizedBox(height: 40.v),
                    _buildRegisterButton(context),
                    SizedBox(height: 18.v),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "msg_already_have_an2".tr,
                              style: CustomTextStyles.bodyLargeff848fad,
                            ),
                            TextSpan(
                                text: "lbl_login".tr,
                                style: CustomTextStyles.titleMediumff14171f,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => NavigatorService.goBack()),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameField(BuildContext context) {
    return Selector<RegisterProvider, TextEditingController?>(
      selector: (
        context,
        provider,
      ) =>
          RegisterProvider.nameFieldController,
      builder: (context, nameFieldController, child) {
        return CustomTextFormField(
          controller: nameFieldController,
          hintText: "lbl_enter_your_name".tr,
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildEmailField(BuildContext context) {
    return Selector<RegisterProvider, TextEditingController?>(
      selector: (
        context,
        provider,
      ) =>
          RegisterProvider.emailFieldController,
      builder: (context, emailFieldController, child) {
        return CustomTextFormField(
          controller: emailFieldController,
          hintText: "msg_enter_your_email2".tr,
          textInputType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || (!isValidEmail(value, isRequired: true))) {
              return "err_msg_please_enter_valid_email".tr;
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildPasswordField(BuildContext context) {
    return Selector<RegisterProvider, TextEditingController?>(
      selector: (
        context,
        provider,
      ) =>
          RegisterProvider.passwordFieldController,
      builder: (context, passwordFieldController, child) {
        return CustomTextFormField(
          controller: passwordFieldController,
          hintText: "msg_enter_your_password".tr,
          textInputType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password".tr;
            }
            return null;
          },
          obscureText: true,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildConfirmPasswordField(BuildContext context) {
    return Selector<RegisterProvider, TextEditingController?>(
      selector: (
        context,
        provider,
      ) =>
          RegisterProvider.confirmPasswordFieldController,
      builder: (context, confirmPasswordFieldController, child) {
        return CustomTextFormField(
          controller: confirmPasswordFieldController,
          hintText: "msg_confirm_your_password".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password".tr;
            }
            return null;
          },
          obscureText: true,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_register".tr,
      onPressed: createAccount,
    );
  }
}
