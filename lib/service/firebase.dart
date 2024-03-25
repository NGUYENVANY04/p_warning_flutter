import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SetToken extends StatefulWidget {
  const SetToken({super.key});

  @override
  State<SetToken> createState() => _SetTokenState();
}

class _SetTokenState extends State<SetToken> {
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
      refdata.child('fcm-token/').update(
        {
          "token": token,
        },
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
