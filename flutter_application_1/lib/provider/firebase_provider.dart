import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/chat.dart';
import 'package:flutter_application_1/model/message.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<UserModel> users = [];
  UserModel? user;
  List<Message> messages = [];
  List<UserModel> search = [];
  List<ChatModel> chats = [];
  List<String> chatsId = [];
  ChatModel? chat;

  Future<List<UserModel>> getAllUsers() async {
    FirebaseFirestore.instance
        .collection('users')
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return users;
  }

  UserModel? getUserById(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = UserModel.fromJson(user.data()!);
      notifyListeners();
    });
    return user;
  }

  List<ChatModel> getAllChats() {
    FirebaseFirestore.instance
        .collection('chats')
        .snapshots(includeMetadataChanges: true)
        .listen((chats) {
      this.chats =
          chats.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return chats;
  }

  ChatModel? getChatById(String chatId) {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .snapshots(includeMetadataChanges: true)
        .listen((chat) {
      this.chat = ChatModel.fromJson(chat.data()!);
      notifyListeners();
    });
    return chat;
  }

  List<ChatModel> getChatsWithUids(List<String> uids) {
    FirebaseFirestore.instance
        .collection('chats')
        .where('usersId', isEqualTo: uids)
        .snapshots(includeMetadataChanges: true)
        .listen((chat) {
      chats = chat.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
    });
    return chats;
  }

  List<Message> getMessages(String chatId) {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  Future<void> searchUser(String name) async {
    search = await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }
}
