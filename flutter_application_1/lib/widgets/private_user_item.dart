import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/model/chat.dart';
import 'package:flutter_application_1/presentation/chat_screen/chat_screen.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_application_1/model/user.dart';

class PrivateUserItem extends StatefulWidget {
  const PrivateUserItem({super.key, required this.user});

  final UserModel user;

  @override
  State<PrivateUserItem> createState() => PrivateUserItemState();
}

class PrivateUserItemState extends State<PrivateUserItem> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<ChatModel>> getChatsWithUids(List<String> uids) async {
    List<ChatModel> toReturnChats = [];
    List<ChatModel> toStore = [];
    var stream =
        FirebaseFirestore.instance.collection('chats').get().asStream();

    await for (var value in stream) {
      toStore =
          value.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
      setState(() {});
    }
    for (int i = 0; i < toStore.length; i++) {
      if (!toStore[i].isGroupChat) {
        if (toStore[i].usersId.length == uids.length &&
            toStore[i].usersId.every(uids.contains)) {
          toReturnChats.insert(0, toStore[i]);
        }
      }
    }
    return toReturnChats;
  }

  void tapPrivateMessage() async {
    List<String> uids = [
      FirebaseAuth.instance.currentUser!.uid,
      widget.user.uid
    ];
    List<ChatModel> chats = await getChatsWithUids(uids);
    String chatID = '';

    if (chats.isEmpty) {
      String chatName =
          "${widget.user.name} ${FirebaseAuth.instance.currentUser!.displayName}";
      chatID = await FirebaseFirestoreService.createPrivateChat(
          name: chatName, usersId: uids);
    } else {
      chatID = chats.first.chatId;
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ChatScreen(chatId: chatID)));
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => tapPrivateMessage(),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 30,
              //backgroundImage: NetworkImage(widget.user.image),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                backgroundColor:
                    widget.user.isOnline ? Colors.green : Colors.grey,
                radius: 5,
              ),
            ),
          ],
        ),
        title: Text(
          widget.user.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Last Active: ${timeago.format(widget.user.lastActive)}',
          maxLines: 2,
          style: const TextStyle(
            color: mainColor,
            fontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ));
}
