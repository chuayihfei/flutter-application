import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_screen/models/dashboard_before_check_in_model.dart';

/// A provider class for the DashboardBeforeCheckInScreen.
///
/// This provider manages the state of the DashboardBeforeCheckInScreen, including the
/// current dashboardBeforeCheckInModelObj
class DashboardBeforeCheckInProvider extends ChangeNotifier {
  DashboardBeforeCheckInModel dashboardBeforeCheckInModelObj =
      DashboardBeforeCheckInModel();

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
