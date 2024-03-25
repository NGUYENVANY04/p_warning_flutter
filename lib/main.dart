import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:p_warning_flutter/homepage.dart';
import 'package:p_warning_flutter/service/dataTempApi.dart';
import 'package:p_warning_flutter/ui/weather/widget_temp.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Temperature>(
          create: (_) => Temperature(),
          child: const InfoWidgetTemp(),
        ),
      ],
      child: MaterialApp(
        title: 'Firebase Messaging Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
