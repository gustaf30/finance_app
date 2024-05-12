// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/signup_form_box.dart';
import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';

class SignUpPage extends StatelessWidget {
  final FirebaseFirestore firestore;
  const SignUpPage({super.key, required this.firestore});

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
          children: [
            SizedBox(height: 80),
            Text(
              'budgy',
              style: AppTextStyles.mediumText.copyWith(
                color: AppColors.beige1,
              )
            ),
            SizedBox(height: 15),
            Icon(
              Icons.person_rounded,
              color: AppColors.beige1,
              size: 50.0,
            ),
            SignUpFormBox(firestore: FirebaseFirestore.instance,),
          ],
        ),
      ),
    );
  }
}