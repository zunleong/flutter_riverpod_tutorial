// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

// ✅ Define top-level background handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   print('💬 Handling a background message: ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Register background handler (only on mobile, not web)
  // if (!kIsWeb) {
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }

  // final messaging = FirebaseMessaging.instance;

  // ✅ Request permissions (iOS requires this)
  // await messaging.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // ✅ Retrieve and log FCM token
  // final token = await messaging.getToken();
  // print('🔥 FCM Token: $token');

  // ✅ Foreground message listener
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('📩 Foreground message: ${message.notification?.title}');
  //   print('📜 Body: ${message.notification?.body}');
  // });

  // ✅ When app opened from terminated/background
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('🚀 Notification opened: ${message.notification?.title}');
  // });

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Messaging Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const HomeScreen(),
    );
  }
}