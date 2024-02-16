import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/new_chat_screen/provider/new_chat_screen_provider.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';
import 'package:flutter_application_1/presentation/search_screen/search_screen.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:flutter_application_1/widgets/private_user_item.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => NewChatScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewChatScreenProvider(),
      child: const NewChatScreen(),
    );
  }
}

class NewChatScreenState extends State<NewChatScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
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

  void addNewGroupChat() async {
    NavigatorService.pushNamed(AppRoutes.newGroupChatScreen);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'),
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
        return Column(
          children: [
            Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    addNewGroupChat();
                  },
                  child: const Text("Add New Group"),
                )),
            Flexible(
                child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: value.users.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => value.users[index].uid !=
                      FirebaseAuth.instance.currentUser?.uid
                  ? PrivateUserItem(user: value.users[index])
                  : const SizedBox(),
            ))
          ],
        );
      }));
}
