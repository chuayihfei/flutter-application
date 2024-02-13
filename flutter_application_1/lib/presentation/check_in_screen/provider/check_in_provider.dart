import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/check_in_screen/models/check_in_model.dart';

/// A provider class for the CheckInScreen.
///
/// This provider manages the state of the CheckInScreen, including the
/// current checkInModelObj
class CheckInProvider extends ChangeNotifier {
  CheckInModel checkInModelObj = CheckInModel();
}
