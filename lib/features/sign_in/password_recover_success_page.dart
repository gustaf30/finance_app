// ignore_for_file: library_private_types_in_public_api

import 'package:finance_app/common/constants/app_colors.dart';
import 'package:finance_app/common/constants/app_text_styles.dart';
import 'package:finance_app/common/widgets/primary_button.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class PasswordRecoverSuccessPage extends StatefulWidget {
  const PasswordRecoverSuccessPage({super.key});

  @override
  _PasswordRecoverSuccessPageState createState() => _PasswordRecoverSuccessPageState();
}

class _PasswordRecoverSuccessPageState extends State<PasswordRecoverSuccessPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recuperar Senha',
          style: AppTextStyles.notSoMediumText
              .copyWith(color: AppColors.darkBlue2),
        ),
        centerTitle: true,
        backgroundColor: AppColors.beige1,
        elevation: 0,
      ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.beige1,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 300, // Ajuste a altura conforme necessário
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  Text(
                    'Verifique seu email',
                    style: AppTextStyles.notSoSmallText
                        .copyWith(color: AppColors.darkBlue2),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: PrimaryButton(
                      text: 'Ok',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
