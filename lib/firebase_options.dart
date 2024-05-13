// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDCdca1_6pvBiXuBLvhuMfu2dkyardKvnA',
    appId: '1:15333055717:web:84478c9e9367657b69080c',
    messagingSenderId: '15333055717',
    projectId: 'finance-db-utfpr-423018',
    authDomain: 'finance-db-utfpr-423018.firebaseapp.com',
    storageBucket: 'finance-db-utfpr-423018.appspot.com',
    measurementId: 'G-34GY5NFKQ2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6EFp5-TIV-ZnzBeUqksCIIg-Fdk9JBxM',
    appId: '1:15333055717:android:9c55ceafce213e8f69080c',
    messagingSenderId: '15333055717',
    projectId: 'finance-db-utfpr-423018',
    storageBucket: 'finance-db-utfpr-423018.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmoVR4Tbj5T42zhd7UAHp3pPacx0hB7q8',
    appId: '1:15333055717:ios:c7b5a048ff7bb5a969080c',
    messagingSenderId: '15333055717',
    projectId: 'finance-db-utfpr-423018',
    storageBucket: 'finance-db-utfpr-423018.appspot.com',
    iosBundleId: 'com.gusta.budgy.financeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmoVR4Tbj5T42zhd7UAHp3pPacx0hB7q8',
    appId: '1:15333055717:ios:c7b5a048ff7bb5a969080c',
    messagingSenderId: '15333055717',
    projectId: 'finance-db-utfpr-423018',
    storageBucket: 'finance-db-utfpr-423018.appspot.com',
    iosBundleId: 'com.gusta.budgy.financeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDCdca1_6pvBiXuBLvhuMfu2dkyardKvnA',
    appId: '1:15333055717:web:ed725901bb5892ea69080c',
    messagingSenderId: '15333055717',
    projectId: 'finance-db-utfpr-423018',
    authDomain: 'finance-db-utfpr-423018.firebaseapp.com',
    storageBucket: 'finance-db-utfpr-423018.appspot.com',
    measurementId: 'G-ZEC36YK40L',
  );
}
