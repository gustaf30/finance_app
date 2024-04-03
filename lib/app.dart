// ignore_for_file: prefer_const_constructors
import 'package:finance_app/features/register/register_user_page.dart';
import 'package:flutter/material.dart';

import 'features/splash/splash_page.dart';
import 'features/onboarding/onboarding_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterUserPage(),
    );
  }
}
