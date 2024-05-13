import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:finance_app/features/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  final FirebaseFirestore firestore;
  const OnboardingPage({super.key, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: Container(
              color: AppColors.lightBlue3,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.lightBlue3,
              child: Image.asset('assets/images/onboarding.png'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'keep your budget',
            style:
                AppTextStyles.mediumText.copyWith(color: AppColors.lightBlue1),
          ),
          Text(
            'with budgy!',
            style:
                AppTextStyles.mediumText.copyWith(color: AppColors.lightBlue1),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PrimaryButton(
              text: 'Começar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpPage(firestore: firestore)),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignInPage(firestore: firestore)),
              );
            },
            child: Text(
              'Já tem conta? Entre aqui',
              style:
                  AppTextStyles.smallText.copyWith(color: AppColors.darkBlue1),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
