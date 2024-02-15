import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/substations_before_check_in_screen/models/substations_before_check_in_model.dart';

/// A provider class for the DahsboardBeforeCheckInPage.
///
/// This provider manages the state of the DahsboardBeforeCheckInPage, including the
/// current dahsboardBeforeCheckInModelObj

// ignore_for_file: must_be_immutable
class SubstationsBeforeCheckInProvider extends ChangeNotifier {
  SubstationsBeforeCheckInModel dahsboardBeforeCheckInModelObj =
      SubstationsBeforeCheckInModel();
}
