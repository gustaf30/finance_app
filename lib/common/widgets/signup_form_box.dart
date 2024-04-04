import 'dart:developer';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'primary_button.dart';

class SignUpFormBox extends StatelessWidget {
  const SignUpFormBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
      decoration: const BoxDecoration(
          color: AppColors.beige1,
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
      margin: const EdgeInsets.only(top: 100, bottom: 50, left: 50, right: 50),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.beige1,
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
            margin: const EdgeInsets.only(
                top: 30, left: 20, right: 20, bottom: 75),
          child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 16.0, left: 16.0, right: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Name',
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
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 30.0, left: 16.0, right: 16.0),
                  child: PrimaryButton(
                    text: 'Sign Up',
                    onPressed: () {
                      log('SignUp button pressed');
                      },
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