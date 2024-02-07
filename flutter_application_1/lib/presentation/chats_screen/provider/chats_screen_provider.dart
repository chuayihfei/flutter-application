import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/chats_screen/models/chats_screen_models.dart';

/// A provider class for the ChatsScreen.
///
/// This provider manages the state of the ChatsScreen, including the
/// current chatsModelObj
class ChatsProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  ChatsModel chatsScreenOneModelObj = ChatsModel();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
