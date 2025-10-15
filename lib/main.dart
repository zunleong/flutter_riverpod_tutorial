// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

// Only works on mobile
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('💬 Handling a background message: ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // if (!kIsWeb) {
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  final token = await messaging.getToken();
  print('🔥 FCM Token: $token');

  FirebaseMessaging.onMessage.listen((message) {
    print('📩 Foreground message: ${message.notification?.title}');
    print('📜 Body: ${message.notification?.body}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('🚀 Notification opened: ${message.notification?.title}');
  });

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