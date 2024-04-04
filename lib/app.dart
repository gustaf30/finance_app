// ignore_for_file: prefer_const_constructors
import 'package:finance_app/features/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'features/sign_in/sign_in_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignInPage(),
    );
  }
}
