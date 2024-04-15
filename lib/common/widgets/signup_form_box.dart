import 'package:finance_app/features/home/home_page.dart';
import 'package:finance_app/features/profile/profile_page.dart';
import 'package:finance_app/features/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'primary_button.dart';

class SignUpFormBox extends StatefulWidget {
  const SignUpFormBox({Key? key}) : super(key: key);

  @override
  _SignUpFormBoxState createState() => _SignUpFormBoxState();
}

class _SignUpFormBoxState extends State<SignUpFormBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.beige1,
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        margin: const EdgeInsets.only(top: 30, bottom: 50, left: 50, right: 50),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.beige1,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              margin: const EdgeInsets.only(
                  top: 0, left: 20, right: 20, bottom: 0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 16.0, left: 16.0, right: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nome completo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Confirme a senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 30.0, left: 16.0, right: 16.0),
                    child: PrimaryButton(
                      text: 'Cadastrar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfilePage()),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                    },
                    child: const Text(
                      'Já tenho uma conta',
                      style: TextStyle(
                        color: AppColors.lightBlue2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}