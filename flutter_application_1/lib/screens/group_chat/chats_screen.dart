import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:provider/provider.dart';

// class ChatsScreen extends StatefulWidget {
//   const ChatsScreen({super.key});

//   @override
//   State<ChatsScreen> createState() => ChatsScreenState();
// }

// class ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
//   final notificationService = NotificationService();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
//     notificationService.firebaseNotification(context);
//   }
// }
