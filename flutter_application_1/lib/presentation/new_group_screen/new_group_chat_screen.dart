import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/presentation/new_group_screen/provider/new_group_chat_provider.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';
import 'package:flutter_application_1/presentation/chat_screen/chat_screen.dart';
import 'package:flutter_application_1/presentation/search_screen/search_screen.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:flutter_application_1/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewGroupChatScreen extends StatefulWidget {
  const NewGroupChatScreen({super.key});

  @override
  State<NewGroupChatScreen> createState() => NewGroupChatScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewGroupChatProvider(),
      child: const NewGroupChatScreen(),
    );
  }
}

class NewGroupChatScreenState extends State<NewGroupChatScreen>
    with WidgetsBindingObserver {
  List<UserModel> usersAddedInGroup = [];
  TextEditingController groupNameController = TextEditingController();

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

  void tapOnUser(UserModel user, bool value) {
    if (value) {
      usersAddedInGroup.add(user);
    } else {
      usersAddedInGroup.remove(user);
    }
  }

  void createGroupButton() async {
    List<String> uids = [];
    String chatId = '';
    for (int i = 0; i < usersAddedInGroup.length; i++) {
      uids.add(usersAddedInGroup[i].uid);
    }
    uids.add(FirebaseAuth.instance.currentUser!.uid);

    chatId = await FirebaseFirestoreService.createGroupChat(
        name: groupNameController.text, usersId: uids);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ChatScreen(chatId: chatId)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Group Chat',
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const UsersSearchScreen())),
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuthService.logOut();
              NavigatorService.pushNamedAndRemoveUntil(
                  AppRoutes.loginWithEmailIdScreen);
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: Consumer<FirebaseProvider>(builder: (context, value, child) {
        return Column(
          children: [
            Row(children: [
              Expanded(
                  child: CustomTextFormField(
                controller: groupNameController,
                hintText: "Group Name",
              )),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                  backgroundColor: mainColor,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_circle_right_rounded,
                        color: Colors.white),
                    onPressed: () => createGroupButton(),
                  ))
            ]),
            SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: usersAddedInGroup.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    // ignore: unnecessary_new
                    return new Column(children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: CircleAvatar(
                              radius: 37,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 35,
                                // backgroundImage: ,
                              ))),
                      SizedBox(
                          width: 80,
                          child: Center(
                            child: Text(
                              usersAddedInGroup[index].name,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ))
                    ]);
                  },
                )),
            Flexible(
                child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: value.users.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => value.users[index].uid !=
                      FirebaseAuth.instance.currentUser?.uid
                  ? GestureDetector(
                      onTap: () => {},
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              //backgroundImage: NetworkImage(widget.user.image),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CircleAvatar(
                                backgroundColor: value.users[index].isOnline
                                    ? Colors.green
                                    : Colors.grey,
                                radius: 5,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          value.users[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Last Active: ${timeago.format(value.users[index].lastActive)}',
                          maxLines: 2,
                          style: const TextStyle(
                            color: mainColor,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        value: value.addedToGroup[index],
                        onChanged: (bool? newValue) {
                          setState(() {
                            value.addedToGroup[index] = newValue!;
                            tapOnUser(
                                value.users[index], value.addedToGroup[index]);
                            for (int i = 0; i < usersAddedInGroup.length; i++) {
                              print("Names: ${usersAddedInGroup[i].name}");
                            }
                          });
                        },
                      ))
                  : const SizedBox(),
            ))
          ],
        );
      }));
}
