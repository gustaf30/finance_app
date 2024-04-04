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
        child: const Column(
          children: [
            SizedBox(height: 100),
            Icon(
              Icons.person_rounded,
              color: AppColors.beige1,
              size: 50.0,
            ),
            SignInFormBox(),
          ],
        ),
      ),
    );
  }
}