// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final FirebaseFirestore firestore;
  const App({super.key, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashPage(firestore: firestore),
    );
  }
}
