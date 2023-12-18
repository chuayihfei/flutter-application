import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/model/chat.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

const channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true);

class NotificationService {
  static const key =
      'AAAAsdEf-ko:APA91bFRG6gfC-xbE9UX-cZwv0Oh2odm7hrn3dnD6k8uASAEoVfj1fWVZGH6x7VgKLpzBP2O6sSw376VeEjYntyi1LVyyAvZuWY-hyvJdESxV2wo_4SULmHpobKUCkpDvP4ALAmtBYAl';
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initLocalNotification() {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestCriticalPermission: true,
        requestSoundPermission: true);

    const initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      debugPrint(response.payload.toString());
    });
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    final styleInfomation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title,
        htmlFormatTitle: true);

    final androidDetails = AndroidNotificationDetails(
        'com.example.flutter_application_1.urgent', 'urgentChannel',
        importance: Importance.max,
        styleInformation: styleInfomation,
        priority: Priority.max);

    const iosDetails =
        DarwinNotificationDetails(presentAlert: true, presentBadge: true);

    final notificationDeatils =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDeatils,
        payload: message.data['body']);
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or had not accepted permission');
    }
  }

  Future<void> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    saveToken(token!);
  }

  Future<void> saveToken(String token) async => await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({'token': token}, SetOptions(merge: true));

  String receiverToken = '';

  Future<void> getReceiverToken(String? receiverId) async {
    final getToken = await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .get();

    receiverToken = await getToken.data()!['token'];
  }

  Future<void> getChatReceiversToken(String? chatId) async {
    ChatModel? chat;
    var stream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .snapshots(includeMetadataChanges: true);

    await for (var value in stream) {
      chat = ChatModel.fromJson(value.data()!);
    }
    List<String> uids = chat!.usersId;
    for (var i = 0; i < uids.length; i++) {
      if (uids[i] != FirebaseAuth.instance.currentUser!.uid) {
        getReceiverToken(uids[i]);
      }
    }
  }

  void firebaseNotification(context) {
    initLocalNotification();

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   await Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (_) => ChatScreen(userId: message.data['senderId']),
    //     ),
    //   );
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showLocalNotification(message);
    });
  }

  Future<void> sendNotification(
      {required String body, required String senderId}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$key'
        },
        body: jsonEncode(<String, dynamic>{
          'to': receiverToken,
          'priority': 'high',
          'notification': <String, dynamic>{
            'body': body,
            'title': 'New Message!',
          },
          'data': <String, String>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'senderId': senderId,
          }
        }),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
