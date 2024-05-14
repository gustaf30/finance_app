// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashPage extends StatelessWidget {
  final FirebaseFirestore firestore;
  const SplashPage({super.key, required this.firestore});

  @override
  Widget build(BuildContext context) {
    // simulando o carregamento
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => OnboardingPage(firestore: firestore),
        ),
      );
    });

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkBlue2,
              AppColors.lightBlue1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Text(
          'budgy',
          style: AppTextStyles.bigText.copyWith(color: AppColors.beige1),
        ),
      ),
    );
  }
}
