import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/message.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/services/firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

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

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = Message(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: receiverId,
        sentTime: DateTime.now(),
        content: content,
        messageType: MessageType.text);
    await addMessageToChat(receiverId, message);
  }

  static Future<void> addImageMesage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = Message(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: receiverId,
        sentTime: DateTime.now(),
        content: image,
        messageType: MessageType.image);

    await addMessageToChat(receiverId, message);
  }

  static Future<void> addMessageToChat(
    String receiverId,
    Message message,
  ) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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

  static Future<void> checkIn(String location) async => await firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({"location": location, "checkedIn": true});

  static Future<void> checkOut() async => await firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({"location": "", "checkedIn": false});
}
