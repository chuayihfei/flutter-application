import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';
import 'package:flutter_application_1/widgets/chat_messages.dart';
import 'package:flutter_application_1/widgets/chat_text_field.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatId});

  final String chatId;

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
        .getMessages(widget.chatId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ChatMessages(chatId: widget.chatId),
                ChatTextField(chatId: widget.chatId)
              ],
            )));
  }

  AppBar buildAppBar() => AppBar(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      title: Consumer<FirebaseProvider>(
        builder: (context, value, build) => value.user != null
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        value.user!.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        value.user!.isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          color:
                              value.user!.isOnline ? Colors.green : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
      ));
}
