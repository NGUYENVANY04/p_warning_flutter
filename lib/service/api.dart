// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:p_warning/firebase_options.dart';
// import 'package:push_notifications_firebase_flutter/message.dart';
// import 'package:push_notifications_firebase_flutter/push_notifications.dart';
// import 'firebase_options.dart';
// import 'home.dart';

// final navigatorKey = GlobalKey<NavigatorState>();
// bool previousState = false;

// Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
//   if (message.notification != null) {
//     print("Background Notification Tapped");
//     navigatorKey.currentState!.pushNamed("/message", arguments: message);
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // Khởi tạo Firebase Messaging
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("Received message: ${message.notification!.title}");
//     // Xử lý thông báo khi ứng dụng đang chạy
//   });

//   // Lắng nghe sự thay đổi trong Realtime Database
//   DatabaseReference reference = FirebaseDatabase.instance.ref();
//   reference.child('state').onValue.listen((event) {
//     bool newState = event.snapshot.value as bool;
//     if (previousState != newState) {
//       _sendNotification();
//     }
//     previousState = newState;
//   });

//   PushNotifications.init();
//   PushNotifications.localNotiInit();

//   // Listen to background notifications
//   FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

//   // for handling in terminated state
//   final RemoteMessage? message =
//       await FirebaseMessaging.instance.getInitialMessage();

//   if (message != null) {
//     print("Launched from terminated state");
//     Future.delayed(Duration(seconds: 1), () {
//       navigatorKey.currentState!.pushNamed("/message", arguments: message);
//     });
//   }
//   runApp(const MyApp());
// }

// void _sendNotification() {
//   PushNotifications.showSimpleNotification(
//     title: 'Trạng thái đã thay đổi',
//     body: 'Trạng thái đã chuyển từ true sang false',
//     payload: 'state_changed',
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       title: 'Push Notifications',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       routes: {
//         '/': (context) => const HomePage(),
//         '/message': (context) => const Message()
//       },
//     );
//   }
// }
