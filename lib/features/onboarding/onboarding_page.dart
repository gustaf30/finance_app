import 'dart:developer';

import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
        Text('keep your budget',
            style:
                AppTextStyles.mediumText.copyWith(color: AppColors.lightBlue1)),
        Text('with bugdy!',
            style:
                AppTextStyles.mediumText.copyWith(color: AppColors.lightBlue1)),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: PrimaryButton(text: 'Get started', onPressed: () {
            log('Get started button pressed');
          }),
        ),
        Text('Already have an account? Log in',
            style:
                AppTextStyles.smallText.copyWith(color: AppColors.darkBlue1)),
        const SizedBox(height: 16),
      ]),
    );
  }
}
