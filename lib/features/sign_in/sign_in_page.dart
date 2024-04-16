import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/widgets/signin_form_box.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
            const SizedBox(height: 80),
            Text(
              'budgy',
              style: AppTextStyles.mediumText.copyWith(
                color: AppColors.beige1,
              )
            ),
            const SizedBox(height: 30),
            const Icon(
              Icons.person_rounded,
              color: AppColors.beige1,
              size: 50.0,
            ),
            const SignInFormBox(),
          ],
        ),
      ),
    );
  }
}