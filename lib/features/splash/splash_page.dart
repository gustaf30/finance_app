// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      // Navega para a página principal após 3 segundos (simulando o carregamento)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => OnboardingPage(), // Substitua pelo nome da sua página principal
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