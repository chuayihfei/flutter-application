import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/models/dashboard_after_check_in_model.dart';

/// A provider class for the DashboardAfterCheckInScreen.
///
/// This provider manages the state of the DashboardAfterCheckInScreen, including the
/// current dashboardAfterCheckInModelObj

// ignore_for_file: must_be_immutable
class DashboardAfterCheckInProvider extends ChangeNotifier {
  DashboardAfterCheckInModel dashboardAfterCheckInModelObj =
      DashboardAfterCheckInModel();
}
