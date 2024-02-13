import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(const MyApp());
  //NotificationService().initLocalNotification();
}

final navigatorKey = GlobalKey<NavigatorState>();

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   get mainColor => null;

//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//         create: (_) => FirebaseProvider(),
//         child: MaterialApp(
//             navigatorKey: navigatorKey,
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//                 elevatedButtonTheme: ElevatedButtonThemeData(
//                   style: ElevatedButton.styleFrom(
//                       textStyle: const TextStyle(fontSize: 20),
//                       minimumSize: const Size.fromHeight(52),
//                       backgroundColor: mainColor),
//                 ),
//                 appBarTheme: const AppBarTheme(
//                   backgroundColor: Colors.transparent,
//                   elevation: 0,
//                   titleTextStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 35,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//             home: const MainPage(),
//             initialRoute: '/',
//             routes: {
//               '/loginScreen': (context) => const LoginScreen(),
//             }),
//       );
// }

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             return const LoginScreen();
//           },
//         ),
//       );
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => FirebaseProvider())
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return MaterialApp(
                theme: theme,
                title: 'internssbs_s_application',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale(
                    'en',
                    '',
                  ),
                ],
                initialRoute: AppRoutes.initialRoute,
                routes: AppRoutes.routes,
              );
            },
          ),
        );
      },
    );
  }
}
