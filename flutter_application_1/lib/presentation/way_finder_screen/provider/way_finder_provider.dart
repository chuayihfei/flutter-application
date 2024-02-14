import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/way_finder_screen/models/way_finder_model.dart';

/// A provider class for the WayFinderScreen.
///
/// This provider manages the state of the Way finder, including the
/// current wayfinder model obj
class WayFinderProvider extends ChangeNotifier {
  WayFinderModel wayFinderObj = WayFinderModel();
}
