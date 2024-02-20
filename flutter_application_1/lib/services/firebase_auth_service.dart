import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAuthService {
  static void logOut() async {
    Future.delayed(const Duration(seconds: 2), () async {
      await FirebaseAuth.instance.signOut();
      FirebaseMessaging.instance.deleteToken();
    });
  }
}
