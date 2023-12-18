import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/chat.dart';
import 'package:flutter_application_1/screens/group_chat/chat_screen.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({super.key, required this.chat});

  final ChatModel chat;

  @override
  State<ChatItem> createState() => ChatItemState();
}

class ChatItemState extends State<ChatItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ChatScreen(chatId: widget.chat.chatId))),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              //backgroundImage: NetworkImage(widget.user.image),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: CircleAvatar(
            //     backgroundColor:
            //         widget.user.isOnline ? Colors.green : Colors.grey,
            //     radius: 5,
            //   ),
            // ),
          ],
        ),
        title: Text(
          widget.chat.chatName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text(
        //   'Last Active: ${timeago.format(widget.user.lastActive)}',
        //   maxLines: 2,
        //   style: const TextStyle(
        //     color: mainColor,
        //     fontSize: 15,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
      ));
}
