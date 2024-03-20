import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCsr502F7KQUkEvbEZSXKS1La_IoCvKf5Y',
    appId: '1:711211469592:android:a0be9625236c9e85f06c6d',
    messagingSenderId: '711211469592',
    projectId: 'p-warning',
    databaseURL: 'https://p-warning-default-rtdb.firebaseio.com',
    storageBucket: 'p-warning.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Messaging Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final refdata = FirebaseDatabase.instance.ref();
  late String? token;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((value) {
      setState(() {
        token = value;
      });
      print("Firebase Messaging Token: $token");
      refdata.child('fcm-token/').update(
        {
          "token": token,
        },
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Messaging Demo'),
      ),
      body: Center(
        child: Text(
          'Ứng dụng đang chờ nhận thông báo...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
