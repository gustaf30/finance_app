// ignore_for_file: prefer_const_constructors

import 'package:finance_app/common/widgets/signup_form_box.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkBlue2,
              AppColors.lightBlue1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: const [
            SizedBox(height: 100),
            Icon(
              Icons.person_rounded,
              color: AppColors.beige1,
              size: 50.0,
            ),
            SignUpFormBox(),
          ],
        ),
      ),
    );
  }
}