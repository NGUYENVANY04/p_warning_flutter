// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDFcituy15ctC_gCF06CH_sHmWJvBFHsa4',
    appId: '1:711211469592:web:73ca25d59de89386f06c6d',
    messagingSenderId: '711211469592',
    projectId: 'p-warning',
    authDomain: 'p-warning.firebaseapp.com',
    databaseURL: 'https://p-warning-default-rtdb.firebaseio.com',
    storageBucket: 'p-warning.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsr502F7KQUkEvbEZSXKS1La_IoCvKf5Y',
    appId: '1:711211469592:android:a0be9625236c9e85f06c6d',
    messagingSenderId: '711211469592',
    projectId: 'p-warning',
    databaseURL: 'https://p-warning-default-rtdb.firebaseio.com',
    storageBucket: 'p-warning.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBU2MrhSNPnFgd7ZLg5PUdMn8NDLa6vZUM',
    appId: '1:711211469592:ios:63bea048d93a1fb8f06c6d',
    messagingSenderId: '711211469592',
    projectId: 'p-warning',
    databaseURL: 'https://p-warning-default-rtdb.firebaseio.com',
    storageBucket: 'p-warning.appspot.com',
    iosBundleId: 'com.example.pWarningFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBU2MrhSNPnFgd7ZLg5PUdMn8NDLa6vZUM',
    appId: '1:711211469592:ios:aafa32aebe840a22f06c6d',
    messagingSenderId: '711211469592',
    projectId: 'p-warning',
    databaseURL: 'https://p-warning-default-rtdb.firebaseio.com',
    storageBucket: 'p-warning.appspot.com',
    iosBundleId: 'com.example.pWarningFlutter.RunnerTests',
  );
}