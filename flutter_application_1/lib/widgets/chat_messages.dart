import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/message.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';
import 'package:flutter_application_1/widgets/empty_widget.dart';
import 'package:flutter_application_1/widgets/message_bubble.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) => Consumer<FirebaseProvider>(
      builder: (context, value, child) => value.messages.isEmpty
          ? const Expanded(
              child: EmptyWidget(
              icon: Icons.waving_hand,
              text: 'Say Hello!',
            ))
          : Expanded(
              child: ListView.builder(
              controller: Provider.of<FirebaseProvider>(context, listen: false)
                  .scrollController,
              itemCount: value.messages.length,
              itemBuilder: (context, index) {
                final isTextMessage =
                    value.messages[index].messageType == MessageType.text;
                final isMe = FirebaseAuth.instance.currentUser!.uid ==
                    value.messages[index].senderId;

                return isTextMessage
                    ? MessageBubble(
                        isMe: isMe,
                        message: value.messages[index],
                        isImage: false,
                      )
                    : MessageBubble(
                        isMe: isMe,
                        message: value.messages[index],
                        isImage: true);
              },
            )));
}
