import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';
import 'package:flutter_application_1/screens/login_screen/login_screen.dart';
import 'package:flutter_application_1/screens/chat/new_chat_screen.dart';
import 'package:flutter_application_1/screens/chat/search_screen.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:flutter_application_1/widgets/chat_item.dart';
import 'package:flutter_application_1/widgets/private_user_item.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => ChatsScreenState();
}

class ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
  final notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Provider.of<FirebaseProvider>(context, listen: false).getAllChats();
    notificationService.firebaseNotification(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({'isOnline': false});
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void logOut() async {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/loginScreen', (Route<dynamic> route) => false);
    Future.delayed(const Duration(seconds: 2), () async {
      await FirebaseAuth.instance.signOut();
      FirebaseMessaging.instance.deleteToken();
    });
  }

  void addNewChat() async {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => const NewChatScreen()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const UsersSearchScreen())),
              icon: const Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
              onPressed: () => logOut(),
              icon: const Icon(Icons.logout, color: Colors.black),
            ),
          ],
        ),
        body: Consumer<FirebaseProvider>(builder: (context, value, child) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: value.chats.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => value.chats[index].usersId
                    .contains(FirebaseAuth.instance.currentUser?.uid)
                ? ChatItem(chat: value.chats[index])
                : const SizedBox(),
          );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () => addNewChat(),
          child: const Icon(Icons.add),
        ),
      );
}
