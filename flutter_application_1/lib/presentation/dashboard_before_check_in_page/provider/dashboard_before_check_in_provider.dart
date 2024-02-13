import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_page/models/dashboard_before_check_in_model.dart';

/// A provider class for the DahsboardBeforeCheckInPage.
///
/// This provider manages the state of the DahsboardBeforeCheckInPage, including the
/// current dahsboardBeforeCheckInModelObj

// ignore_for_file: must_be_immutable
class DahsboardBeforeCheckInProvider extends ChangeNotifier {
  DahsboardBeforeCheckInModel dahsboardBeforeCheckInModelObj =
      DahsboardBeforeCheckInModel();
}
