import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_container_screen/models/dashboard_before_check_in_container_model.dart';

/// A provider class for the DahsboardBeforeCheckInContainerScreen.
///
/// This provider manages the state of the DahsboardBeforeCheckInContainerScreen, including the
/// current dahsboardBeforeCheckInContainerModelObj

// ignore_for_file: must_be_immutable
class DahsboardBeforeCheckInContainerProvider extends ChangeNotifier {
  DahsboardBeforeCheckInContainerModel dahsboardBeforeCheckInContainerModelObj =
      DahsboardBeforeCheckInContainerModel();
}
