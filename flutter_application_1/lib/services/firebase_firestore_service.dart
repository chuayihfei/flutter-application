import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/chat.dart';
import 'package:flutter_application_1/model/message.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/services/firebase_storage_service.dart';
import 'package:uuid/uuid.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;
  static const uuid = Uuid();

  static Future<void> createUser({
    required String name,
    required String email,
    required uid,
  }) async {
    final user = UserModel(
        name: name,
        lastActive: DateTime.now(),
        uid: uid,
        email: email,
        isOnline: true);

    await firestore.collection('users').doc(uid).set(user.toJson());
  }

  static Future<String> createPrivateChat(
      {required String name, required List<String> usersId}) async {
    final chatID = uuid.v1();
    final chat = ChatModel(
        chatId: chatID, chatName: name, isGroupChat: false, usersId: usersId);

    await firestore.collection('chats').doc(chatID).set(chat.toJson());
    return chatID;
  }

  static Future<String> createGroupChat(
      {required String name, required List<String> usersId}) async {
    final chatID = uuid.v1();
    final chat = ChatModel(
        chatId: chatID, chatName: name, isGroupChat: true, usersId: usersId);

    await firestore.collection('chats').doc(chatID).set(chat.toJson());
    return chatID;
  }

  static Future<void> addTextMessage({
    required String content,
    required String chatId,
  }) async {
    final message = Message(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        senderName: FirebaseAuth.instance.currentUser!.displayName.toString(),
        chatId: chatId,
        sentTime: DateTime.now(),
        content: content,
        messageType: MessageType.text);
    await addMessageToChat(chatId, message);
  }

  static Future<void> addImageMesage({
    required String chatId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = Message(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        senderName: FirebaseAuth.instance.currentUser!.displayName.toString(),
        chatId: chatId,
        sentTime: DateTime.now(),
        content: image,
        messageType: MessageType.image);

    await addMessageToChat(chatId, message);
  }

  static Future<void> addMessageToChat(
    String chatId,
    Message message,
  ) async {
    // await firestore
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection('chat')
    //     .doc(receiverId)
    //     .collection('messages')
    //     .add(message.toJson());

    // await firestore
    //     .collection('users')
    //     .doc(receiverId)
    //     .collection('chat')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection('messages')
    //     .add(message.toJson());
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toJson());
  }

  static Future<void> updateUserData(Map<String, dynamic> data) async =>
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

  static Future<List<UserModel>> searchUser(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("name", isGreaterThanOrEqualTo: name)
        .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  static Future<void> checkIn(String location) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"location": location, "checkedIn": true});

    await firestore
        .collection('locations')
        .doc(location)
        .update({"number of people": FieldValue.increment(1)});
  }

  static Future<void> checkOut(String location) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"location": "", "checkedIn": false});

    await firestore
        .collection('locations')
        .doc(location)
        .update({"number of people": FieldValue.increment(-1)});
  }

  static Future<void> locationCheckIn(String location) async => await firestore
      .collection('locations')
      .doc(location)
      .update({"number of people": FieldValue.increment(1)});

  static Future<void> locationCheckOut(String location) async => await firestore
      .collection('locations')
      .doc(location)
      .update({"number of people": FieldValue.increment(-1)});

  static Future<void> stationCheckIn(String location, String station) async =>
      await firestore
          .collection('locations/$location/substations')
          .doc(station)
          .update({
        "number of people": FieldValue.increment(1),
        "users": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });

  static Future<void> stationCheckOut(String location, String station) async =>
      await firestore
          .collection('locations/$location/substations')
          .doc(station)
          .update({
        "number of people": FieldValue.increment(-1),
        "users":
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
      });
}
