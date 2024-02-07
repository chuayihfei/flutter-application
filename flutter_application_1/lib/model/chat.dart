import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String chatName;
  final bool isGroupChat;
  final List<String> usersId;

  const ChatModel(
      {required this.chatId,
      required this.chatName,
      required this.isGroupChat,
      required this.usersId});

  factory ChatModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return ChatModel(
      chatId: data?['chatId'],
      chatName: data?['chatName'],
      isGroupChat: data?['isGroupChat'],
      usersId: data?['usersId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "chatId": chatId,
      "chatName": chatName,
      "isGroupChat": isGroupChat,
      "usersId": usersId,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatId: json['chatId'],
        chatName: json['chatName'],
        isGroupChat: json['isGroupChat'],
        usersId: List<String>.from(json['usersId']),
      );

  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'chatName': chatName,
        'isGroupChat': isGroupChat,
        'usersId': usersId,
      };
}
